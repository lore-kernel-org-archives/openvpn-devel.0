Message-ID: <45ef346e-868c-b5de-5937-6ae9fc0d578f@...1227...>
Date: Thu, 10 Mar 2022 16:32:43 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <99203e85-fc9e-906e-61e2-0ab250371f1f@...2663...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <99203e85-fc9e-906e-61e2-0ab250371f1f@...2663...>
Subject: Re: [Openvpn-devel] OpenVPN Client 2FA problem with Backslash
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Jakob Curdes <jc@...2663...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 10.03.22 um 15:14 schrieb Jakob Curdes:
> Hello all,
> 
> I think I have found a bug in the OpenVPN Windows client , can you help 
> me to determine if this is true and how to proceed?
> 
> We are trying to implement 2FA for several existing Firebox SSL VPNs 
> (which essentially uses OpenVPN on server and client side). The remote 
> users all use the Windows OpenVPN client. This works perfectly without 
> 2FA, and it works also if you do not need to specify the authentication 
> domain on user logon. But for the migration it is necessary to do that 
> as I cannot convert all users at once - the domain you enter in the 
> username field is then "authpoint" instead of something like 
> "company.private". In the 2FA process, the OpenVPN client then opens a 
> text window where you can enter a TOTP token or a "p" for a push 
> request. The Backslash is no problem when not using 2FA, then the user 
> auth succeeds.
> So it seems in the part for the extra control message handling handles 
> backslashes incorrect.
> 

Be aware that there is a also a newer 2FA method based on auth-pending 
that addresses many of the shortcoming of the old AUTH_FAILED based method.

> /Typed in Username: authpoint\UserN and corresponding password/
> 
> Thu Mar 10 10:35:31 2022 VERIFY OK: depth=0, O=WatchGuard_Technologies, 
> OU=Fireware, CN=Fireware SSLVPN Server
> Thu Mar 10 10:35:31 2022 Control Channel: TLSv1.2, cipher TLSv1.2 
> ECDHE-RSA-CHACHA20-POLY1305, peer certificate: 2048 bit RSA, signature: 
> RSA-SHA256
> Thu Mar 10 10:35:31 2022 [Fireware SSLVPN Server] Peer Connection 
> Initiated with [AF_INET]1.2.3.4:443
> Thu Mar 10 10:35:32 2022 MANAGEMENT: >STATE:1646904932,GET_CONFIG,,,,,,
> Thu Mar 10 10:35:32 2022 SENT CONTROL [Fireware SSLVPN Server]: 
> 'PUSH_REQUEST' (status=1)
> Thu Mar 10 10:35:32 2022 AUTH: Received control message: 
> AUTH_FAILED,CRV1:R,E:1796:Yoirtuqeprtiqrew4==:*Type "p" to receive a 
> push notification or type your one-time password*
> 
> /(Typed in "p")
> /
> Thu Mar 10 10:35:32 2022 SIGUSR1[soft,auth-failure] received, process 

Where are you typing this in? in the normal cmd.exe terminal that runs 
OpenVPN? because that looks like the client just gives you the 
AUTH_FAILED and then proceeds to connect to the next server.

> restarting
> Thu Mar 10 10:35:32 2022 MANAGEMENT: 
>  >STATE:1646904932,RECONNECTING,auth-failure,,,,,
> Thu Mar 10 10:35:32 2022 Restart pause, 5 second(s)
> *Thu Mar 10 10:35:40 2022 Previous command sent to management failed: 
> ERROR: Options warning: Bad backslash ('\') usage in TCP:0: remember 
> that backslashes are treated as shell-escapes and if you need to pass 
> backslash characters as part of a Windows filename, you sho*
> Thu Mar 10 10:35:40 2022 MANAGEMENT: CMD 'username "Auth" 
> "*authpoint\UserN*"'
> Thu Mar 10 10:35:40 2022 MANAGEMENT: CMD 'password [...]'
> 
> This sounds like I need to escape the backslash, but if I do this the 
> auth fails completely before the 2FA part comes into the picture.
> Other tricks like forward slashes or "@" do not help here as these are 
> not understood by the auth backend in the firebox.
> When using the WatchGuard SSL VPN app this all works (and it has OpenVPN 
> inside....) but I would like to stick to the OpenVPN clients as all the 
> users already have it and know how to handle it.
> 
> Best regards and thank you for hints,

The new auth-pending method is much easier to implement. With the old 
method you need to part the AUTH_FAILED message and wait until the 
client asks again for the user password on the next connection and give 
the session password/repsonse then.

For the new method, example of implmentating it on Android:

parsing of the info message:

https://github.com/schwabe/ics-openvpn/blob/97546b9f8b51c0dc60d591b96ae835f00f2b6805/main/src/main/java/de/blinkt/openvpn/core/OpenVPNService.java#L1323


and sending the response:

https://github.com/schwabe/ics-openvpn/blob/97546b9f8b51c0dc60d591b96ae835f00f2b6805/main/src/main/java/de/blinkt/openvpn/core/OpenVpnManagementThread.java#L748

