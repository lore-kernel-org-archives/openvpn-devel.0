References: <CAKh=nwF5PZ2CbEARe7-D=0dxt-XjRR-+2Z=16pENVzzxfgZM8A@...278...>
 <707c4845-6d3b-e9ba-0e8a-36f27d85bab3@...1856...>
 <CAKh=nwEFfwQnRTMc1D-4tb8DWOpJOPPD82fBZ2pRwNYdihJA8g@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <9491d49e-a858-b3ad-21ab-1ee3b86ef41a@...1856...>
Date: Sat, 6 Jan 2018 00:11:09 +0100
MIME-Version: 1.0
In-Reply-To: <CAKh=nwEFfwQnRTMc1D-4tb8DWOpJOPPD82fBZ2pRwNYdihJA8g@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] PKCS#11 - a little bit of help?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Emmanuel Deloget <logout@...260...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Emmanuel,

On 03-01-18 18:13, Emmanuel Deloget wrote:
> Hello Steffan, 
> 
> On Mon, Jan 1, 2018 at 4:36 PM, Steffan Karger <steffan@...1856...
> <mailto:steffan@...1856...>> wrote:
> 
>     Hi,
> 
>     On 01-01-18 14:57, Emmanuel Deloget wrote:
>     > I'm trying to get openvpn read my certificates from a TPM2 using a
>     > specially crafted PKCS#11 provider (the existing tpm2-pk11 is quite
>     > limited for now but I might be able to extend it). 
>     >
>     > However, the PKCS#11 API is not something I'm comfortable with, and I'd
>     > like to know if there is some document (design or anything, really) that
>     > could help me to understand what openvpn wants exactly in order for me
>     > to provide the missing bits. I've read the documents at [1] but found
>     > nothing here of interest (for me). 
>     >
>     > So, does someone have any pointer?
> 
>     You're right that OpenVPN's pkcs11 options lack some high-level
>     documentation.  Maybe I can shed some light on the basics (probably
>     taking a step further back than you need).
> 
>     First, you need some shared object (.so, .dll) that provides the
>     interface specified by the PKCS11 standard.  OpenVPN will load that
>     module, and call its functions to provide private key operations.  That
>     shared object is usually provided by your smartcard vendor.  That shared
>     object takes care of communication with the underlying key store (smart
>     card, tpm, hsm, ...).  The openvpn manpage calls this a pkcs11
>     'provider'.
> 
>     $ openvpn --show-pkcs11-ids
>     /usr/lib/x86_64-linux-gnu/pkcs11/gnome-keyring-pkcs11.so
> 
>     The following objects are available for use.
>     Each object shown below may be used as parameter to
>     --pkcs11-id option please remember to use single quote mark.
> 
> 
> 
> ​I seen that while testing. ​
> 
>  
> 
> 
>     Certificate
>            DN:             C=KG, ST=NA, O=OpenVPN-TEST, CN=Test-Client,
>     emailAddress=me@...430...
>            Serial:         02
>            Serialized id:
>     Gnome\x20Keyring/1\x2E0/1\x3AUSER\x3ADEFAULT/Gnome2\x20Key\x20Storage/1A9D824585217F1BD54603E83F042F570A2EE9F2
> 
>     (I have the openvpn client testkey in my local gnome keyring, to easily
>     test pkcs11 without a hardware token.)
> 
>     From that list, you pick the object you want to use, and specify the
>     provider and id in your config file.  In this case:
> 
>     pkcs11-providers
>     "/usr/lib/x86_64-linux-gnu/pkcs11/gnome-keyring-pkcs11.so"
>     pkcs11-id
>     "Gnome\\x20Keyring/1\\x2E0/1\\x3AUSER\\x3ADEFAULT/Gnome2\\x20Key\\x20Storage/1B3B2BEBF36576443D3A903AFA8997221B93FCC1"
> 
>     You specify this *instead* of the regular 'key' and 'cert' options.
>     Note that you'll need toe escape backslashes.
> 
> 
> ​Good to know :)​
> 
>  
> 
>     You should now be able to use pkcs11 for the private key operations.
> 
>     Since each keystore behaves differently, I did not specify how to get
>     the private key in there.  But I guess your TPM vendor providers tooling
>     for that.
> 
> 
> Well, TPM2 is a keystore, so that should work :)
> 
> I am able to store the certificate in the TPM2 nvram (as a DER file) and
> I have a corresponding RSA private key (also in the TPM2, in the
> persistent object area).
> 
> The PKCS11 provider I'm using (tpm2-pk11) has been modified to get the
> certificate from the TPM2, but I don't know how to tell openvpn to use
> the corresponding key on the TPM2 (and to use the
> TPM2_RSA_encrypt/RSA_decrypt functions). 
> 
> I'm not sure what's missing here (probably something on my side, either
> some config or some code here and there). Here are the PKCS#11 ids and
> my current configuration:
> 
>     root@...2370... ~# openvpn --show-pkcs11-ids
> 
>     The following objects are available for use.
>     Each object shown below may be used as parameter to
>     --pkcs11-id option please remember to use single quote mark.
> 
>     Certificate
>            DN:             C=FR, O=ME, OU=Unit, CN=005043361C24
>            Serial:       
>      CFC3AC7FC37F777CF509506BC8EA0A94E9FBDC121686FEBEACEF99AC474ED21D
>            Serialized id:  ME/TPM2/00000000/nvram/01800008
> 
>     Certificate
>            DN:             C=US, O=ME, OU=Unit, CN=006060584526
>            Serial:         266B18A3534E3179
>            Serialized id:  ME/TPM2/00000000/nvram/01800004
> 
> 
> 
> 
> 
> 
>     client
>     # -- yeah, this is not the real server :)
>     remote openvpn.example.com <http://openvpn.example.com>
>     port 443
>     dev tun
>     persist-key
>     persist-tun
>     proto tcp6-client
>     tun-mtu 1500
>     auth SHA256
>     connect-retry-max 3
>     remap-usr1 SIGTERM
> 
>     remote-cert-tls server
>     tls-client
>     ca /etc/PKI/CA.pem
>     tls-auth /etc/PKI/TA.ta 1
>     cipher AES-256-CBC
>     script-security 2
>     pkcs11-providers "/usr/lib/libtpm2-pk11.so"
> 
>     # -- in DER format
> 
>     pkcs11-id "ME/TPM2/00000000/nvram/01800008"
> 
>     # -------------------- previous key configuration ----------------------
>     # -- same as ME/TPM2/00000000/nvram/01800008
>     # cert /etc/PKI/client.pem
>     # -- also in the TPM2, but how to tell that to openvpn?
>     # key /etc/PKI/client.key
> 
>     up /etc/openvpn/start.sh
>     down /etc/openvpn/stop.sh
> 
>     comp-lzo
>     verb 11
> 
>     float
> 
> 
> 
> In my understanding, and within a context of dual authentication (server
> identifies client, client identifies server), I should see the following
> set of operation: 
> 
> * fetch the certificate
> * initiate communication and so some RSA magic
> * everything's ok? continue
> 
> Of course, I might be wrong. What I see is (with some printf within the
> PKCS#11 provider, you can ignore them but they give you an idea of what
> happens)
> 
>     root@...2370... ~# openvpn --config /etc/openvpn/client.conf
>     Wed Jan  3 17:53:38 2018 us=413562 OpenVPN 2.4.0
>     aarch64-openwrt-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL]
>     [PKCS11] [MH/PKTINFO] [AEAD]
>     Wed Jan  3 17:53:38 2018 us=413603 library versions: OpenSSL 1.0.2k 
>     26 Jan 2017, LZO 2.09
>     Wed Jan  3 17:53:38 2018 us=413773 PKCS#11: Adding PKCS#11 provider
>     '/usr/lib/libtpm2-pk11.so'
>     Wed Jan  3 17:53:38 2018 us=413812 PKCS#11: pkcs11h_addProvider
>     entry version='1.22', pid=27700,
>     reference='/usr/lib/libtpm2-pk11.so',
>     provider_location='/usr/lib/libtpm2-pk11.so',
>     allow_protected_auth=0, mask_private_mode=00000000, cert_is_private=0
>     Wed Jan  3 17:53:38 2018 us=413832 PKCS#11: Adding provider
>     '/usr/lib/libtpm2-pk11.so'-'/usr/lib/libtpm2-pk11.so'
>     ---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_GetFunctionList
>     ---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_Initialize
>     ---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_GetInfo
>     Wed Jan  3 17:53:38 2018 us=423143 PKCS#11: pkcs11h_addProvider
>     Provider '/usr/lib/libtpm2-pk11.so' manufacturerID 'ME'
>     Wed Jan  3 17:53:38 2018 us=423182 PKCS#11:
>     _pkcs11h_slotevent_notify entry
>     Wed Jan  3 17:53:38 2018 us=423197 PKCS#11:
>     _pkcs11h_slotevent_notify return
>     Wed Jan  3 17:53:38 2018 us=423216 PKCS#11: Provider
>     '/usr/lib/libtpm2-pk11.so' added rv=0-'CKR_OK'
>     Wed Jan  3 17:53:38 2018 us=423230 PKCS#11: pkcs11h_addProvider
>     return rv=0-'CKR_OK'
>     Wed Jan  3 17:53:38 2018 us=423263 NOTE: the current
>     --script-security setting may allow this configuration to call
>     user-defined scripts
>     Wed Jan  3 17:53:38 2018 us=423733 PKCS#11:
>     pkcs11h_certificate_deserializeCertificateId entry
>     p_certificate_id=0x7ffeb0a098, sz='ME/TPM2/00000000/nvram/01800008'
>     Wed Jan  3 17:53:38 2018 us=423760 PKCS#11:
>     _pkcs11h_certificate_newCertificateId entry
>     p_certificate_id=0x7ffeb0a050
>     Wed Jan  3 17:53:38 2018 us=423776 PKCS#11:
>     _pkcs11h_certificate_newCertificateId return rv=0-'CKR_OK',
>     *p_certificate_id=0x2501d9d0
>     Wed Jan  3 17:53:38 2018 us=423798 PKCS#11:
>     pkcs11h_token_deserializeTokenId entry p_token_id=0x2501d9d0,
>     sz='ME/TPM2/00000000/nvram'
>     Wed Jan  3 17:53:38 2018 us=423813 PKCS#11:
>     _pkcs11h_token_newTokenId entry p_token_id=0x7ffeb09fb8
>     Wed Jan  3 17:53:38 2018 us=423833 PKCS#11:
>     _pkcs11h_token_newTokenId return rv=0-'CKR_OK', *p_token_id=0x2501de30
>     Wed Jan  3 17:53:38 2018 us=423854 PKCS#11:
>     pkcs11h_token_deserializeTokenId return rv=0-'CKR_OK'
>     Wed Jan  3 17:53:38 2018 us=423881 PKCS#11:
>     pkcs11h_certificate_deserializeCertificateId return rv=0-'CKR_OK'
>     Wed Jan  3 17:53:38 2018 us=423899 PKCS#11:
>     pkcs11h_certificate_create entry certificate_id=0x2501d9d0,
>     user_data=(nil), mask_prompt=00000003, pin_cache_period=-1,
>     p_certificate=0x7ffeb0a0a0
>     Wed Jan  3 17:53:38 2018 us=423918 PKCS#11:
>     pkcs11h_certificate_duplicateCertificateId entry to=0x2501e2a0
>     form=0x2501d9d0
>     Wed Jan  3 17:53:38 2018 us=423934 PKCS#11:
>     pkcs11h_certificate_duplicateCertificateId return rv=0-'CKR_OK',
>     *to=0x2501e310
>     Wed Jan  3 17:53:38 2018 us=423948 PKCS#11:
>     _pkcs11h_session_getSessionByTokenId entry token_id=0x2501e740,
>     p_session=0x2501e2b0
>     Wed Jan  3 17:53:38 2018 us=423961 PKCS#11: Creating a new session
>     Wed Jan  3 17:53:38 2018 us=423976 PKCS#11:
>     pkcs11h_token_duplicateTokenId entry to=0x2501ebc8 form=0x2501e740
>     Wed Jan  3 17:53:38 2018 us=423994 PKCS#11:
>     pkcs11h_token_duplicateTokenId return rv=0-'CKR_OK', *to=0x2501ec30
>     Wed Jan  3 17:53:38 2018 us=424008 PKCS#11:
>     _pkcs11h_session_getSessionByTokenId return rv=0-'CKR_OK',
>     *p_session=0x2501ebb0
>     Wed Jan  3 17:53:38 2018 us=424021 PKCS#11:
>     pkcs11h_certificate_create return rv=0-'CKR_OK'
>     *p_certificate=0x2501e2a0
>     Wed Jan  3 17:53:38 2018 us=424036 PKCS#11:
>     pkcs11h_openssl_createSession - entry
>     Wed Jan  3 17:53:38 2018 us=424086 PKCS#11:
>     pkcs11h_openssl_createSession - return openssl_session=0x2501f0e0
>     Wed Jan  3 17:53:38 2018 us=424101 PKCS#11:
>     pkcs11h_openssl_session_getEVP - entry openssl_session=0x2501f0e0
>     Wed Jan  3 17:53:38 2018 us=424117 PKCS#11:
>     pkcs11h_openssl_session_getX509 - entry openssl_session=0x2501f0e0
>     Wed Jan  3 17:53:38 2018 us=424132 PKCS#11: pkcs11h_openssl_getX509
>     - entry certificate=0x2501e2a0
>     Wed Jan  3 17:53:38 2018 us=758314 PKCS#11:
>     pkcs11h_certificate_getCertificateBlob entry certificate=0x2501e2a0,
>     certificate_blob=(nil), *p_certificate_blob_size=0000000000000000
>     Wed Jan  3 17:53:38 2018 us=758608 PKCS#11:
>     __pkcs11h_certificate_loadCertificate entry certificate=0x2501e2a0
>     Wed Jan  3 17:53:38 2018 us=758805 PKCS#11:
>     _pkcs11h_session_validate entry session=0x2501ebb0
>     Wed Jan  3 17:53:38 2018 us=758996 PKCS#11:
>     _pkcs11h_session_validate return rv=179-'CKR_SESSION_HANDLE_INVALID'
>     Wed Jan  3 17:53:38 2018 us=759184 PKCS#11:
>     __pkcs11h_certificate_loadCertificate return
>     rv=179-'CKR_SESSION_HANDLE_INVALID'
>     Wed Jan  3 17:53:38 2018 us=759416 PKCS#11:
>     _pkcs11h_certificate_resetSession entry certificate=0x2501e2a0,
>     public_only=1, session_mutex_locked=0
>     Wed Jan  3 17:53:38 2018 us=759629 PKCS#11: _pkcs11h_session_login
>     entry session=0x2501ebb0, is_publicOnly=1, readonly=1,
>     user_data=(nil), mask_prompt=00000003
>     Wed Jan  3 17:53:38 2018 us=759812 PKCS#11: _pkcs11h_session_logout
>     entry session=0x2501ebb0
>     Wed Jan  3 17:53:38 2018 us=759985 PKCS#11: _pkcs11h_session_logout
>     return
>     Wed Jan  3 17:53:38 2018 us=760175 PKCS#11: _pkcs11h_session_reset
>     entry session=0x2501ebb0, user_data=(nil), mask_prompt=00000003,
>     p_slot=0x7ffeb09a28
>     Wed Jan  3 17:53:38 2018 us=760363 PKCS#11: _pkcs11h_session_reset
>     Expected token manufacturerID='ME' model='TPM2',
>     serialNumber='00000000', label='nvram'
>     Wed Jan  3 17:53:38 2018 us=760554 PKCS#11:
>     _pkcs11h_session_getSlotList entry provider=0x250093c0,
>     token_present=1, pSlotList=0x7ffeb098c8, pulCount=0x7ffeb098d0
>     ---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_GetSlotList
>     ---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_GetSlotList
>     Wed Jan  3 17:53:38 2018 us=760880 PKCS#11:
>     _pkcs11h_session_getSlotList return rv=0-'CKR_OK' *pulCount=1
>     ---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_GetTokenInfo
>     Wed Jan  3 17:53:38 2018 us=761228 PKCS#11:
>     _pkcs11h_token_getTokenId entry p_token_id=0x7ffeb098d8
>     Wed Jan  3 17:53:38 2018 us=761422 PKCS#11:
>     _pkcs11h_token_newTokenId entry p_token_id=0x7ffeb09818
>     Wed Jan  3 17:53:38 2018 us=761615 PKCS#11:
>     _pkcs11h_token_newTokenId return rv=0-'CKR_OK', *p_token_id=0x2501f5d0
>     Wed Jan  3 17:53:38 2018 us=761811 PKCS#11:
>     _pkcs11h_token_getTokenId return rv=0-'CKR_OK', *p_token_id=0x2501f5d0
>     Wed Jan  3 17:53:38 2018 us=761995 PKCS#11: _pkcs11h_session_reset
>     Found token manufacturerID='ME' model='TPM2',
>     serialNumber='00000000', label='nvram'
>     Wed Jan  3 17:53:38 2018 us=762296 PKCS#11:
>     pkcs11h_token_freeTokenId entry certificate_id=0x2501f5d0
>     Wed Jan  3 17:53:38 2018 us=762474 PKCS#11:
>     pkcs11h_token_freeTokenId return
>     Wed Jan  3 17:53:38 2018 us=762656 PKCS#11: _pkcs11h_session_reset
>     return rv=0-'CKR_OK', *p_slot=4660
>     ---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_OpenSession
>     ---- OBJS | tpm2-pk11-e4589948e8/src/objects.c:object_load
>     ---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_list
>     ---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_readpublic [H =
>     0x81010001]
>     ---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_readpublic [H =
>     0x81010002]
>     ---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_nvlist
>     ++++ ++++ | nvlist.count = 4
>     ++++ ++++ | loading nvram index = 01800004
>     ---- CERT |
>     tpm2-pk11-e4589948e8/src/certificate.c:certificate_read_from_tpm
>     [index = 01800004]
>     ---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_nvread [index = 01800004]
>     ---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_nvreadpublic [index =
>     01800004]
>     ++++ ++++ | added object 0x2503cbd0, certificate 0x2503ccb8
>     ++++ ++++ | loading nvram index = 01800008
>     ---- CERT |
>     tpm2-pk11-e4589948e8/src/certificate.c:certificate_read_from_tpm
>     [index = 01800008]
>     ---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_nvread [index = 01800008]
>     ---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_nvreadpublic [index =
>     01800008]
>     ++++ ++++ | added object 0x2503c2c0, certificate 0x2503d568
>     Wed Jan  3 17:53:39 2018 us=209982 PKCS#11: _pkcs11h_session_login
>     return rv=0-'CKR_OK'
>     Wed Jan  3 17:53:39 2018 us=210058 PKCS#11:
>     _pkcs11h_certificate_resetSession return rv=0-'CKR_OK'
>     Wed Jan  3 17:53:39 2018 us=210106 PKCS#11:
>     __pkcs11h_certificate_loadCertificate entry certificate=0x2501e2a0
>     Wed Jan  3 17:53:39 2018 us=210150 PKCS#11:
>     _pkcs11h_session_validate entry session=0x2501ebb0
>     Wed Jan  3 17:53:39 2018 us=210194 PKCS#11:
>     _pkcs11h_session_validate session->pin_expire_time=0, time=1514998419
>     Wed Jan  3 17:53:39 2018 us=210237 PKCS#11:
>     _pkcs11h_session_validate return rv=0-'CKR_OK'
>     Wed Jan  3 17:53:39 2018 us=210282 PKCS#11:
>     _pkcs11h_session_findObjects entry session=0x2501ebb0,
>     filter=0x7ffeb09f30, filter_attrs=2, p_objects=0x7ffeb09f08,
>     p_objects_found=0x7ffeb09f10
>     ---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_FindObjectsInit
>     [filters<2> = 0x7ffeb09f30]
>     ++++ ++++ | filter[0].type = 0x00000000
>     ++++ ++++ | filter[1].type = 0x00000102
>     ---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_FindObjects
>     ---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_list
>     ++++ ++++ | object = 0x2503c2c0, handle = 38632038
>     ++++ ++++ | >> type = 00000000 = CKA_CLASS, value = 00000001 =
>     CKO_CERTIFICATE (expected 00000001 = CKO_CERTIFICATE)
>     ++++ ++++ | >> type = 00000102 = CKA_ID, value = 08008001
>     ++++ ++++ | filtered = no
>     ++++ ++++ | object = 0x2503cbd0, handle = 30382031
>     ++++ ++++ | >> type = 00000000 = CKA_CLASS, value = 00000001 =
>     CKO_CERTIFICATE (expected 00000001 = CKO_CERTIFICATE)
>     ++++ ++++ | >> type = 00000102 = CKA_ID, value = 04008001
>     ++++ ++++ | filtered = yes
>     ++++ ++++ | object = 0x2503be30, handle = 00000000
>     ++++ ++++ | >> type = 00000000 = CKA_CLASS, value = 00000002 =
>     CKO_PUBLIC_KEY (expected 00000001 = CKO_CERTIFICATE)
>     ++++ ++++ | filtered = yes
>     ++++ ++++ | object = 0x2503b7e0, handle = 81010002
>     ++++ ++++ | >> type = 00000000 = CKA_CLASS, value = 00000003 =
>     CKO_PRIVATE_KEY (expected 00000001 = CKO_CERTIFICATE)
>     ++++ ++++ | filtered = yes
>     ++++ ++++ | object = 0x2503b850, handle = 00000000
>     ++++ ++++ | >> type = 00000000 = CKA_CLASS, value = 00000002 =
>     CKO_PUBLIC_KEY (expected 00000001 = CKO_CERTIFICATE)
>     ++++ ++++ | filtered = yes
>     ++++ ++++ | object = 0x25038960, handle = 81010001
>     ++++ ++++ | >> type = 00000000 = CKA_CLASS, value = 00000003 =
>     CKO_PRIVATE_KEY (expected 00000001 = CKO_CERTIFICATE)
>     ++++ ++++ | filtered = yes
>     ---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_FindObjects
>     ---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_list
>     ---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_FindObjectsFinal
>     Wed Jan  3 17:53:39 2018 us=593596 PKCS#11:
>     _pkcs11h_session_findObjects return rv=0-'CKR_OK', *p_objects_found=1
>     Wed Jan  3 17:53:39 2018 us=593900 PKCS#11:
>     _pkcs11h_session_getObjectAttributes entry session=0x2501ebb0,
>     object=621003456, attrs=0x7ffeb09f18, count=1
>     ---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_GetAttributeValue
>     ---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_GetAttributeValue
>     Wed Jan  3 17:53:39 2018 us=595105 PKCS#11:
>     _pkcs11h_session_getObjectAttributes return rv=0-'CKR_OK'
>     Wed Jan  3 17:53:39 2018 us=595333 PKCS#11:
>     _pkcs11h_certificate_isBetterCertificate entry current=(nil),
>     current_size=0000000000000000, newone=0x2503dd70,
>     newone_size=00000000000006f9
>     Wed Jan  3 17:53:39 2018 us=595538 PKCS#11:
>     _pkcs11h_certificate_isBetterCertificate return is_better=1
>     Wed Jan  3 17:53:39 2018 us=595750 PKCS#11:
>     _pkcs11h_session_freeObjectAttributes entry attrs=0x7ffeb09f18, count=1
>     Wed Jan  3 17:53:39 2018 us=595943 PKCS#11:
>     _pkcs11h_session_freeObjectAttributes return
>     Wed Jan  3 17:53:39 2018 us=596137 PKCS#11:
>     __pkcs11h_certificate_updateCertificateIdDescription entry
>     certificate_id=0x2501e310
>     Wed Jan  3 17:53:39 2018 us=598698 PKCS#11:
>     __pkcs11h_certificate_updateCertificateIdDescription return
>     displayName='/C=FR/O=ME/OU=Unit/CN=005043361C24 on nvram'
>     Wed Jan  3 17:53:39 2018 us=599056 PKCS#11:
>     __pkcs11h_certificate_loadCertificate return rv=0-'CKR_OK'
>     Wed Jan  3 17:53:39 2018 us=599287 PKCS#11:
>     pkcs11h_certificate_getCertificateBlob return rv=0-'CKR_OK'
>     Wed Jan  3 17:53:39 2018 us=599501 PKCS#11:
>     pkcs11h_certificate_getCertificateBlob entry certificate=0x2501e2a0,
>     certificate_blob=0x2503dd70, *p_certificate_blob_size=00000000000006f9
>     Wed Jan  3 17:53:39 2018 us=599706 PKCS#11:
>     pkcs11h_certificate_getCertificateBlob return rv=0-'CKR_OK'
>     Wed Jan  3 17:53:39 2018 us=601366 PKCS#11: pkcs11h_openssl_getX509
>     - return rv=0-'CKR_OK', x509=0x2501f140
>     Wed Jan  3 17:53:39 2018 us=603117 PKCS#11:
>     pkcs11h_openssl_session_getX509 - return x509=0x2503b3a0
>     Wed Jan  3 17:53:39 2018 us=603610 PKCS#11:
>     __pkcs11h_openssl_session_setRSA - entered
>     openssl_session=0x2501f0e0, evp=0x2503f500
>     Wed Jan  3 17:53:39 2018 us=603936 PKCS#11:
>     __pkcs11h_openssl_session_setRSA - return ret=1
>     Wed Jan  3 17:53:39 2018 us=604451 PKCS#11:
>     pkcs11h_openssl_session_getEVP - return ret=0x2503f500
>     Wed Jan  3 17:53:39 2018 us=604675 PKCS#11:
>     pkcs11h_openssl_session_getX509 - entry openssl_session=0x2501f0e0
>     Wed Jan  3 17:53:39 2018 us=606373 PKCS#11:
>     pkcs11h_openssl_session_getX509 - return x509=0x2503b3a0
>     Wed Jan  3 17:53:39 2018 us=606982 PKCS#11:
>     pkcs11h_openssl_freeSession - entry openssl_session=0x2501f0e0, count=2
>     Wed Jan  3 17:53:39 2018 us=607204 PKCS#11:
>     pkcs11h_openssl_freeSession - return
>     Wed Jan  3 17:53:39 2018 us=607419 PKCS#11:
>     pkcs11h_certificate_freeCertificateId entry certificate_id=0x2501d9d0
>     Wed Jan  3 17:53:39 2018 us=941247 PKCS#11:
>     pkcs11h_token_freeTokenId entry certificate_id=0x2501de30
>     Wed Jan  3 17:53:39 2018 us=941584 PKCS#11:
>     pkcs11h_token_freeTokenId return
>     Wed Jan  3 17:53:39 2018 us=941791 PKCS#11:
>     pkcs11h_certificate_freeCertificateId return
>     Wed Jan  3 17:53:39 2018 us=953836 Outgoing Control Channel
>     Authentication: Using 256 bit message hash 'SHA256' for HMAC
>     authentication
>     Wed Jan  3 17:53:39 2018 us=954201 Incoming Control Channel
>     Authentication: Using 256 bit message hash 'SHA256' for HMAC
>     authentication
>     Wed Jan  3 17:53:39 2018 us=954428 crypto_adjust_frame_parameters:
>     Adjusting frame parameters for crypto by 40 bytes
>     Wed Jan  3 17:53:39 2018 us=954712 LZO compression initializing
>     Wed Jan  3 17:53:39 2018 us=956154 Control Channel MTU parms [
>     L:1624 D:1170 EF:80 EB:0 ET:0 EL:3 ]
>     Wed Jan  3 17:53:39 2018 us=956821 Data Channel MTU parms [ L:1624
>     D:1450 EF:124 EB:406 ET:0 EL:3 ]
>     Wed Jan  3 17:53:39 2018 us=957295 crypto_adjust_frame_parameters:
>     Adjusting frame parameters for crypto by 68 bytes
>     Wed Jan  3 17:53:39 2018 us=957517 calc_options_string_link_mtu:
>     link-mtu 1624 -> 1572
>     Wed Jan  3 17:53:39 2018 us=957867 crypto_adjust_frame_parameters:
>     Adjusting frame parameters for crypto by 68 bytes
>     Wed Jan  3 17:53:39 2018 us=958188 calc_options_string_link_mtu:
>     link-mtu 1624 -> 1572
>     Wed Jan  3 17:53:39 2018 us=958537 Local Options String (VER=V4):
>     'V4,dev-type tun,link-mtu 1572,tun-mtu 1500,proto
>     TCPv4_CLIENT,comp-lzo,keydir 1,cipher AES-256-CBC,auth
>     SHA256,keysize 256,tls-auth,key-method 2,tls-client'
>     Wed Jan  3 17:53:39 2018 us=958753 Expected Remote Options String
>     (VER=V4): 'V4,dev-type tun,link-mtu 1572,tun-mtu 1500,proto
>     TCPv4_SERVER,comp-lzo,keydir 0,cipher AES-256-CBC,auth
>     SHA256,keysize 256,tls-auth,key-method 2,tls-server'
>     Wed Jan  3 17:53:39 2018 us=959174 TCP/UDP: Preserving recently used
>     remote address: [AF_INET6]2a01:240:1906:1:0:1850:6118:4075:443
>     Wed Jan  3 17:53:39 2018 us=959666 Socket Buffers: R=[87380->87380]
>     S=[16384->16384]
>     Wed Jan  3 17:53:39 2018 us=959952 Attempting to establish TCP
>     connection with [AF_INET6]2a01:240:1906:1:0:1850:6118:4075:443
>     [nonblock]
>     Wed Jan  3 17:53:40 2018 us=961428 TCP: connect to
>     [AF_INET6]2a01:240:1906:1:0:1850:6118:4075:443 failed: Connection
>     refused
>     Wed Jan  3 17:53:40 2018 us=962721 SIGTERM[connection
>     failed(soft),init_instance] received, process exiting
>     Wed Jan  3 17:53:40 2018 us=964538 PKCS#11: pkcs11h_terminate entry
>     Wed Jan  3 17:53:40 2018 us=964779 PKCS#11: Terminating openssl
>     Wed Jan  3 17:53:40 2018 us=964979 PKCS#11: _pkcs11h_openssl_terminate
>     Wed Jan  3 17:53:40 2018 us=965557 PKCS#11: Removing providers
>     Wed Jan  3 17:53:40 2018 us=965792 PKCS#11: pkcs11h_removeProvider
>     entry reference='/usr/lib/libtpm2-pk11.so'
>     Wed Jan  3 17:53:40 2018 us=965990 PKCS#11: Removing provider
>     '/usr/lib/libtpm2-pk11.so'
>     ---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_Finalize
>     Wed Jan  3 17:53:40 2018 us=966236 PKCS#11:
>     _pkcs11h_slotevent_notify entry
>     Wed Jan  3 17:53:40 2018 us=966424 PKCS#11:
>     _pkcs11h_slotevent_notify return
>     Wed Jan  3 17:53:40 2018 us=968218 PKCS#11: pkcs11h_removeProvider
>     return rv=0-'CKR_OK'
>     Wed Jan  3 17:53:40 2018 us=968463 PKCS#11: Releasing sessions
>     Wed Jan  3 17:53:40 2018 us=968654 PKCS#11: Warning: Found session
>     with references
>     Wed Jan  3 17:53:40 2018 us=968852 PKCS#11:
>     pkcs11h_token_freeTokenId entry certificate_id=0x2501ec30
>     Wed Jan  3 17:53:40 2018 us=969138 PKCS#11:
>     pkcs11h_token_freeTokenId return
>     Wed Jan  3 17:53:40 2018 us=969380 PKCS#11:
>     pkcs11h_certificate_freeCertificateIdList entry cert_id_list=(nil)
>     Wed Jan  3 17:53:40 2018 us=969569 PKCS#11:
>     pkcs11h_certificate_freeCertificateIdList return
>     Wed Jan  3 17:53:40 2018 us=969795 PKCS#11: Terminating slotevent
>     Wed Jan  3 17:53:40 2018 us=969977 PKCS#11:
>     _pkcs11h_slotevent_terminate entry
>     Wed Jan  3 17:53:40 2018 us=970154 PKCS#11:
>     _pkcs11h_slotevent_terminate return
>     Wed Jan  3 17:53:40 2018 us=970327 PKCS#11: Marking as uninitialized
> 
> 
> 
> Unfortunately, there is no RSA-related log, so I cannot check what
> openvpn is doing with the certificate it found - so at this point, I'm a
> bit confused.

It does not do any RSA operations, because it does not connect:

Wed Jan  3 17:53:39 2018 us=959952 Attempting to establish TCP
connection with [AF_INET6]2a01:240:1906:1:0:1850:6118:4075:443 [nonblock]
Wed Jan  3 17:53:40 2018 us=961428 TCP: connect to
[AF_INET6]2a01:240:1906:1:0:1850:6118:4075:443 failed: Connection refused

... and then it tears down the instance.

TLS will only do the RSA operations after a few handshake messages have
been exchanged, and it has something to sign.  If you connect to a real
server (even with the wrong certificate), you should see more.

-Steffan

