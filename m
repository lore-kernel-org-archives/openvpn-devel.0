References: <551A5509.702@...277...> <20150824181826.GD34798@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <55DB85F9.60706@...1227...>
Date: Mon, 24 Aug 2015 23:00:41 +0200
MIME-Version: 1.0
In-Reply-To: <20150824181826.GD34798@...1296...>
Content-Type: multipart/alternative;
	boundary="------------080607000300000308010402"
Subject: Re: [Openvpn-devel] Increasing TUN_MTU_MIN to make connection
 establishment faster
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Jiri Horky <jiri.horky@...277...>
Cc: FF Systems <ff-system@...2025...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080607000300000308010402
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1
 
On 24.08.2015 20:18, Gert Doering wrote:
> Hi, > > On Tue, Mar 31, 2015 at 10:04:25AM +0200, Jiri Horky wrote: >>
continuing yesterday's IRC discussion. I would like to ask whether you
>> can think of a reason why TUN_MTU_MIN is set to only 100 bytes, and
>> maybe more importantly, why this value is effectively enforced in
function > > I'm not sure if you've been following the list and/or git
master > commits, but we have somehing in master for a while now... > >
commit fc91d4b0071178e298052078431fb86f03be84fc (master) > > Author:
Steffan Karger > Date:   Tue Jun 30 21:44:56 2015 +0200 > >     
Increase control channel packet size for faster handshakes > >     
Signed-off-by: Steffan Karger <steffan@...1856...> >      Acked-by: Gert
Doering <gert@...1296...> >      Message-Id:
<1435693496-10931-1-git-send-email-steffan@...1856...> >      URL:
http://article.gmane.org/gmane.network.openvpn.devel/9841 >     
Signed-off-by: Gert Doering <gert@...1296...> > > > ... and as far
as we can see, this "just works" (and OpenVPN 3 on iOS > and Android
also uses larger packets for the control channel, so we're > just
following suit here). >
OpenVPN Android also uses this patch (and Gert's faster connect patch)
for two weeks now and bad reports about the new version (apart from a
lot of broken config with extra arguments ... :( )

Arne
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (MingW32)
 
iEYEARECAAYFAlXbhfkACgkQe8+cMNS4zRcDgQCgqWq2swsrCjleyNDV/5pAJFpx
x5IAoM9j/ZH1Tbu3BC4GvlFbUkZU85Yn
=IRXC
-----END PGP SIGNATURE-----


--------------080607000300000308010402
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <br>
    -----BEGIN PGP SIGNED MESSAGE----- <br>
    Hash: SHA1 <br>
    =A0<br>
    On 24.08.2015 20:18, Gert Doering wrote:<br>
    <span style=3D"white-space: pre;">&gt; Hi,
&gt;
&gt; On Tue, Mar 31, 2015 at 10:04:25AM +0200, Jiri Horky wrote:
&gt;&gt; continuing yesterday's IRC discussion. I would like to ask whether=
 you
&gt;&gt; can think of a reason why TUN_MTU_MIN is set to only 100 bytes, and
&gt;&gt; maybe more importantly, why this value is effectively enforced in =
function
&gt;
&gt; I'm not sure if you've been following the list and/or git master
&gt; commits, but we have somehing in master for a while now...
&gt;
&gt; commit fc91d4b0071178e298052078431fb86f03be84fc (master)
&gt;
&gt; Author: Steffan Karger
&gt; Date:=A0=A0 Tue Jun 30 21:44:56 2015 +0200
&gt;
&gt;=A0=A0=A0=A0=A0 Increase control channel packet size for faster handsha=
kes
&gt;
&gt;=A0=A0=A0=A0=A0 Signed-off-by: Steffan Karger <a class=3D"moz-txt-link-=
rfc2396E" href=3D"mailto:steffan@...1856...">&lt;steffan@...1856...&gt;</a>
&gt;=A0=A0=A0=A0=A0 Acked-by: Gert Doering <a class=3D"moz-txt-link-rfc2396=
E" href=3D"mailto:gert@...1296...">&lt;gert@...1296...&gt;</a>
&gt;=A0=A0=A0=A0=A0 Message-Id: <a class=3D"moz-txt-link-rfc2396E" href=3D"=
mailto:1435693496-10931-1-git-send-email-steffan@...1856...">&lt;1435693496=
-10931-1-git-send-email-steffan@...1856...&gt;</a>
&gt;=A0=A0=A0=A0=A0 URL: <a class=3D"moz-txt-link-freetext" href=3D"http://=
article.gmane.org/gmane.network.openvpn.devel/9841">http://article.gmane.or=
g/gmane.network.openvpn.devel/9841</a>
&gt;=A0=A0=A0=A0=A0 Signed-off-by: Gert Doering <a class=3D"moz-txt-link-rf=
c2396E" href=3D"mailto:gert@...1296...">&lt;gert@...1296...&gt;</a>
&gt;
&gt;
&gt; ... and as far as we can see, this "just works" (and OpenVPN 3 on iOS
&gt; and Android also uses larger packets for the control channel, so we're
&gt; just following suit here).
&gt;</span><br>
    OpenVPN Android also uses this patch (and Gert's faster connect
    patch) for two weeks now and bad reports about the new version
    (apart from a lot of broken config with extra arguments ... :( )<br>
    <br>
    Arne<br>
    -----BEGIN PGP SIGNATURE-----
<br>
    Version: GnuPG v2.0.22 (MingW32)
<br>
    =A0<br>
    iEYEARECAAYFAlXbhfkACgkQe8+cMNS4zRcDgQCgqWq2swsrCjleyNDV/5pAJFpx
<br>
    x5IAoM9j/ZH1Tbu3BC4GvlFbUkZU85Yn
<br>
    =3DIRXC
<br>
    -----END PGP SIGNATURE-----
<br>
    <br>
  </body>
</html>

--------------080607000300000308010402--

