Content-Type: multipart/alternative;
 boundary="------------qK0l2W2iHsL5xx7lv2w8ijJB"
Message-ID: <99203e85-fc9e-906e-61e2-0ab250371f1f@...2663...>
Date: Thu, 10 Mar 2022 15:14:05 +0100
MIME-Version: 1.0
From: Jakob Curdes <jc@...2663...>
Content-Language: en-US
Subject: [Openvpn-devel] OpenVPN Client 2FA problem with Backslash
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------qK0l2W2iHsL5xx7lv2w8ijJB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,

I think I have found a bug in the OpenVPN Windows client , can you help 
me to determine if this is true and how to proceed?

We are trying to implement 2FA for several existing Firebox SSL VPNs 
(which essentially uses OpenVPN on server and client side). The remote 
users all use the Windows OpenVPN client. This works perfectly without 
2FA, and it works also if you do not need to specify the authentication 
domain on user logon. But for the migration it is necessary to do that 
as I cannot convert all users at once - the domain you enter in the 
username field is then "authpoint" instead of something like 
"company.private". In the 2FA process, the OpenVPN client then opens a 
text window where you can enter a TOTP token or a "p" for a push 
request. The Backslash is no problem when not using 2FA, then the user 
auth succeeds.
So it seems in the part for the extra control message handling handles 
backslashes incorrect.

/Typed in Username: authpoint\UserN and corresponding password/

Thu Mar 10 10:35:31 2022 VERIFY OK: depth=0, O=WatchGuard_Technologies, 
OU=Fireware, CN=Fireware SSLVPN Server
Thu Mar 10 10:35:31 2022 Control Channel: TLSv1.2, cipher TLSv1.2 
ECDHE-RSA-CHACHA20-POLY1305, peer certificate: 2048 bit RSA, signature: 
RSA-SHA256
Thu Mar 10 10:35:31 2022 [Fireware SSLVPN Server] Peer Connection 
Initiated with [AF_INET]1.2.3.4:443
Thu Mar 10 10:35:32 2022 MANAGEMENT: >STATE:1646904932,GET_CONFIG,,,,,,
Thu Mar 10 10:35:32 2022 SENT CONTROL [Fireware SSLVPN Server]: 
'PUSH_REQUEST' (status=1)
Thu Mar 10 10:35:32 2022 AUTH: Received control message: 
AUTH_FAILED,CRV1:R,E:1796:Yoirtuqeprtiqrew4==:*Type "p" to receive a 
push notification or type your one-time password*

/(Typed in "p")
/
Thu Mar 10 10:35:32 2022 SIGUSR1[soft,auth-failure] received, process 
restarting
Thu Mar 10 10:35:32 2022 MANAGEMENT: 
 >STATE:1646904932,RECONNECTING,auth-failure,,,,,
Thu Mar 10 10:35:32 2022 Restart pause, 5 second(s)
*Thu Mar 10 10:35:40 2022 Previous command sent to management failed: 
ERROR: Options warning: Bad backslash ('\') usage in TCP:0: remember 
that backslashes are treated as shell-escapes and if you need to pass 
backslash characters as part of a Windows filename, you sho*
Thu Mar 10 10:35:40 2022 MANAGEMENT: CMD 'username "Auth" 
"*authpoint\UserN*"'
Thu Mar 10 10:35:40 2022 MANAGEMENT: CMD 'password [...]'

This sounds like I need to escape the backslash, but if I do this the 
auth fails completely before the 2FA part comes into the picture.
Other tricks like forward slashes or "@" do not help here as these are 
not understood by the auth backend in the firebox.
When using the WatchGuard SSL VPN app this all works (and it has OpenVPN 
inside....) but I would like to stick to the OpenVPN clients as all the 
users already have it and know how to handle it.

Best regards and thank you for hints,

Jakob Curdes


--------------qK0l2W2iHsL5xx7lv2w8ijJB
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hello all, <br>
    </p>
    <p>I think I have found a bug in the OpenVPN Windows client , can
      you help me to determine if this is true and how to proceed? <br>
    </p>
    <p>We are trying to implement 2FA for several existing Firebox SSL
      VPNs (which essentially uses OpenVPN on server and client side).
      The remote users all use the Windows OpenVPN client. This works
      perfectly without 2FA, and it works also if you do not need to
      specify the authentication domain on user logon. But for the
      migration it is necessary to do that as I cannot convert all users
      at once - the domain you enter in the username field is then
      "authpoint" instead of something like "company.private". In the
      2FA process, the OpenVPN client then opens a text window where you
      can enter a TOTP token or a "p" for a push request. The Backslash
      is no problem when not using 2FA, then the user auth succeeds. <br>
      So it seems in the part for the extra control message handling
      handles backslashes incorrect. <br>
    </p>
    <p><i>Typed in Username: authpoint\UserN and corresponding password</i><br>
    </p>
    <p>Thu Mar 10 10:35:31 2022 VERIFY OK: depth=0,
      O=WatchGuard_Technologies, OU=Fireware, CN=Fireware SSLVPN Server<br>
      Thu Mar 10 10:35:31 2022 Control Channel: TLSv1.2, cipher TLSv1.2
      ECDHE-RSA-CHACHA20-POLY1305, peer certificate: 2048 bit RSA,
      signature: RSA-SHA256<br>
      Thu Mar 10 10:35:31 2022 [Fireware SSLVPN Server] Peer Connection
      Initiated with [AF_INET]1.2.3.4:443<br>
      Thu Mar 10 10:35:32 2022 MANAGEMENT:
      &gt;STATE:1646904932,GET_CONFIG,,,,,,<br>
      Thu Mar 10 10:35:32 2022 SENT CONTROL [Fireware SSLVPN Server]:
      'PUSH_REQUEST' (status=1)<br>
      Thu Mar 10 10:35:32 2022 AUTH: Received control message:
      AUTH_FAILED,CRV1:R,E:1796:Yoirtuqeprtiqrew4==:<b>Type "p" to
        receive a push notification or type your one-time password</b></p>
    <p><i>(Typed in "p")<br>
      </i><br>
      Thu Mar 10 10:35:32 2022 SIGUSR1[soft,auth-failure] received,
      process restarting<br>
      Thu Mar 10 10:35:32 2022 MANAGEMENT:
      &gt;STATE:1646904932,RECONNECTING,auth-failure,,,,,<br>
      Thu Mar 10 10:35:32 2022 Restart pause, 5 second(s)<br>
      <b>Thu Mar 10 10:35:40 2022 Previous command sent to management
        failed: ERROR: Options warning: Bad backslash ('\') usage in
        TCP:0: remember that backslashes are treated as shell-escapes
        and if you need to pass backslash characters as part of a
        Windows filename, you sho</b><br>
      Thu Mar 10 10:35:40 2022 MANAGEMENT: CMD 'username "Auth" "<b>authpoint\UserN</b>"'<br>
      Thu Mar 10 10:35:40 2022 MANAGEMENT: CMD 'password [...]'</p>
    <p>This sounds like I need to escape the backslash, but if I do this
      the auth fails completely before the 2FA part comes into the
      picture. <br>
      Other tricks like forward slashes or "@" do not help here as these
      are not understood by the auth backend in the firebox. <br>
      When using the WatchGuard SSL VPN app this all works (and it has
      OpenVPN inside....) but I would like to stick to the OpenVPN
      clients as all the users already have it and know how to handle
      it. <br>
    </p>
    <p>Best regards and thank you for hints, <br>
    </p>
    <p>Jakob Curdes</p>
    <p><br>
    </p>
  </body>
</html>

--------------qK0l2W2iHsL5xx7lv2w8ijJB--

