/*****************************************************************************************************
 * Copyright 2013 appscape gmbh
 * Copyright 2014-2016 SPECURE GmbH
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *****************************************************************************************************/

import Foundation

final class RMBTTOS: NSObject {
    
    @objc public static let shared = RMBTTOS()
    
    @objc public dynamic var lastAcceptedVersion: Int
    @objc public let currentVersion: Int = Int(RMBTConfig.RMBT_TOS_VERSION)

    override public init() {
        lastAcceptedVersion = UserDefaults.getTOSVersion()
    }

    func isCurrentVersionAccepted(with settings: SettingsResponse.Settings.TermsAndConditions) -> Bool {
        /// Lexita: Laikom 0 versija kaip tiesiog nepriimta. On accept, vietoj 0 saugosim 1
        return lastAcceptedVersion != 0 && lastAcceptedVersion >= settings.version
    }

    public func acceptCurrentVersion(with settings: SettingsResponse.Settings.TermsAndConditions) {
        lastAcceptedVersion = settings.version
        if(lastAcceptedVersion == 0){
            /// Lexita: serveris vis grazina versija null (isparsinama kaip 0), del to jei acceptina 0 versija, settinu kaip 1
            Log.logger.debug("[REDLOG] lastAcceptedVersion is 0, setting 1")
            lastAcceptedVersion = 1
        }
        UserDefaults.storeTOSVersion(lastAcceptedVersion:lastAcceptedVersion)
    }
}
