MIME-Version: 1.0
References: <99203e85-fc9e-906e-61e2-0ab250371f1f@...2663...>
In-Reply-To: <99203e85-fc9e-906e-61e2-0ab250371f1f@...2663...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 10 Mar 2022 12:51:51 -0500
Message-ID: <CAKuzo_ioneE7-WX68GNgVE_dSK1LqoxtEOZwyoafEb7596-s+g@...278...>
Content-Type: multipart/alternative; boundary="00000000000057539805d9e0dfcb"
Subject: Re: [Openvpn-devel] OpenVPN Client 2FA problem with Backslash
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jakob Curdes <jc@...2663...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000057539805d9e0dfcb
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Mar 10, 2022 at 9:15 AM Jakob Curdes <jc@...2663...> wrote:

> Hello all,
>
> I think I have found a bug in the OpenVPN Windows client , can you help me
> to determine if this is true and how to proceed?
>
> We are trying to implement 2FA for several existing Firebox SSL VPNs
> (which essentially uses OpenVPN on server and client side). The remote
> users all use the Windows OpenVPN client. This works perfectly without 2FA,
> and it works also if you do not need to specify the authentication domain
> on user logon. But for the migration it is necessary to do that as I cannot
> convert all users at once - the domain you enter in the username field is
> then "authpoint" instead of something like "company.private". In the 2FA
> process, the OpenVPN client then opens a text window where you can enter a
> TOTP token or a "p" for a push request. The Backslash is no problem when
> not using 2FA, then the user auth succeeds.
> So it seems in the part for the extra control message handling handles
> backslashes incorrect.
>
> *Typed in Username: authpoint\UserN and corresponding password*
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
> AUTH_FAILED,CRV1:R,E:1796:Yoirtuqeprtiqrew4==:*Type "p" to receive a push
> notification or type your one-time password*
>
>
> *(Typed in "p") *
> Thu Mar 10 10:35:32 2022 SIGUSR1[soft,auth-failure] received, process
> restarting
> Thu Mar 10 10:35:32 2022 MANAGEMENT:
> >STATE:1646904932,RECONNECTING,auth-failure,,,,,
> Thu Mar 10 10:35:32 2022 Restart pause, 5 second(s)
> *Thu Mar 10 10:35:40 2022 Previous command sent to management failed:
> ERROR: Options warning: Bad backslash ('\') usage in TCP:0: remember that
> backslashes are treated as shell-escapes and if you need to pass backslash
> characters as part of a Windows filename, you sho*
> Thu Mar 10 10:35:40 2022 MANAGEMENT: CMD 'username "Auth" "
> *authpoint\UserN*"'
> Thu Mar 10 10:35:40 2022 MANAGEMENT: CMD 'password [...]'
>
> This sounds like I need to escape the backslash, but if I do this the auth
> fails completely before the 2FA part comes into the picture.
> Other tricks like forward slashes or "@" do not help here as these are not
> understood by the auth backend in the firebox.
> When using the WatchGuard SSL VPN app this all works (and it has OpenVPN
> inside....) but I would like to stick to the OpenVPN clients as all the
> users already have it and know how to handle it.
>

I missed this follow up on the devel list. Please see my reply to
openvpn-users. If @ doesnt work there is no easy fix short of patching the
GUI.

Selva

--00000000000057539805d9e0dfcb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Thu, Mar 10, 2022 at 9:15 AM Jakob Curdes &lt;<=
a href=3D"mailto:jc@...2663...">jc@...2663...</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
=20=20
=20=20=20=20
=20=20
  <div>
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
      &quot;authpoint&quot; instead of something like &quot;company.private=
&quot;. In the
      2FA process, the OpenVPN client then opens a text window where you
      can enter a TOTP token or a &quot;p&quot; for a push request. The Bac=
kslash
      is no problem when not using 2FA, then the user auth succeeds. <br>
      So it seems in the part for the extra control message handling
      handles backslashes incorrect. <br>
    </p>
    <p><i>Typed in Username: authpoint\UserN and corresponding password</i>=
<br>
    </p>
    <p>Thu Mar 10 10:35:31 2022 VERIFY OK: depth=3D0,
      O=3DWatchGuard_Technologies, OU=3DFireware, CN=3DFireware SSLVPN Serv=
er<br>
      Thu Mar 10 10:35:31 2022 Control Channel: TLSv1.2, cipher TLSv1.2
      ECDHE-RSA-CHACHA20-POLY1305, peer certificate: 2048 bit RSA,
      signature: RSA-SHA256<br>
      Thu Mar 10 10:35:31 2022 [Fireware SSLVPN Server] Peer Connection
      Initiated with [AF_INET]<a href=3D"http://1.2.3.4:443" target=3D"_bla=
nk">1.2.3.4:443</a><br>
      Thu Mar 10 10:35:32 2022 MANAGEMENT:
      &gt;STATE:1646904932,GET_CONFIG,,,,,,<br>
      Thu Mar 10 10:35:32 2022 SENT CONTROL [Fireware SSLVPN Server]:
      &#39;PUSH_REQUEST&#39; (status=3D1)<br>
      Thu Mar 10 10:35:32 2022 AUTH: Received control message:
      AUTH_FAILED,CRV1:R,E:1796:Yoirtuqeprtiqrew4=3D=3D:<b>Type &quot;p&quo=
t; to
        receive a push notification or type your one-time password</b></p>
    <p><i>(Typed in &quot;p&quot;)<br>
      </i><br>
      Thu Mar 10 10:35:32 2022 SIGUSR1[soft,auth-failure] received,
      process restarting<br>
      Thu Mar 10 10:35:32 2022 MANAGEMENT:
      &gt;STATE:1646904932,RECONNECTING,auth-failure,,,,,<br>
      Thu Mar 10 10:35:32 2022 Restart pause, 5 second(s)<br>
      <b>Thu Mar 10 10:35:40 2022 Previous command sent to management
        failed: ERROR: Options warning: Bad backslash (&#39;\&#39;) usage in
        TCP:0: remember that backslashes are treated as shell-escapes
        and if you need to pass backslash characters as part of a
        Windows filename, you sho</b><br>
      Thu Mar 10 10:35:40 2022 MANAGEMENT: CMD &#39;username &quot;Auth&quo=
t; &quot;<b>authpoint\UserN</b>&quot;&#39;<br>
      Thu Mar 10 10:35:40 2022 MANAGEMENT: CMD &#39;password [...]&#39;</p>
    <p>This sounds like I need to escape the backslash, but if I do this
      the auth fails completely before the 2FA part comes into the
      picture. <br>
      Other tricks like forward slashes or &quot;@&quot; do not help here a=
s these
      are not understood by the auth backend in the firebox. <br>
      When using the WatchGuard SSL VPN app this all works (and it has
      OpenVPN inside....) but I would like to stick to the OpenVPN
      clients as all the users already have it and know how to handle
      it.</p></div></blockquote><div><br></div><div>I missed this follow up=
 on the devel list. Please see my reply to openvpn-users. If=C2=A0@ doesnt =
work=C2=A0there is no easy fix short=C2=A0of patching the GUI.</div><div><b=
r></div><div>Selva=C2=A0</div></div></div>

--00000000000057539805d9e0dfcb--

