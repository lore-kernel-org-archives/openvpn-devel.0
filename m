Message-ID: <4F3CFE39.80803@...515...>
Date: Thu, 16 Feb 2012 15:01:45 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4F39094B.7030805@...277...> <4F390B9C.0@...1114...>
	<4F3970C2.5030000@...277...>
In-Reply-To: <4F3970C2.5030000@...277...>
Content-Type: multipart/alternative;
	boundary="------------030406010609030102080102"
Subject: Re: [Openvpn-devel] Obfuscation for Iran SSL blocking
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jun Matsushita <junflow@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------030406010609030102080102
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Jun,

I would try David's obfsproxy + OpenVPN suggestion first and reconsider
if that fails.
If we would add obfuscation into OpenVPN itself, we'd soon be in the
same cat and mouse game as Tor, with the exception we don't have the
same amount of developer interest to follow it through. So, I think
keeping the obfuscation functionality would be challenging in the long run.

- --=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


> Hi David,
>
> I replied to you directly, maybe it got caught in your spam filter?
>
> Anyone else has some thoughts about developing an obfsproxy-style
> component for OpenVPN?
>
> Best,
>
> Jun.
>
> On 13/02/2012 13:09, David Sommerseth wrote:
> > On 13/02/12 13:59, Jun Matsushita wrote:
> >> This is my first post in this list. As probably a lot of you
> >> heard, Iran has stepped up its filtering by apparently blocking
> >> SSL/TLS using DPI. This is a good read about what's happening
> >> http://news.ycombinator.com/item?id=3D3575029. As these statistics
> >> from TOR attest
> >>
https://metrics.torproject.org/users.html?graph=3Ddirect-users&start=3D2012=
-01-12&end=3D2012-02-12&country=3Dir&events=3Don&dpi=3D72#direct-users
>
> >>
>
> > the impact has been immediate and surely concerns the majority of
> > tools
> >> out there.
>
> >> Does OpenVPN allow the use of some form of Obfuscation (such as
> >> the one TOR is testing now and seem to work from within Iran
> >> https://www.torproject.org/projects/obfsproxy-instructions.html.en)?
>
> >> Anyone has thoughts about this or would be interested in
> >> discussing the matter?
>
>
> > Hi Jun,
>
> > OpenVPN uses SSL under the hood. But it does some tricks to allow
> > SSL over UDP (SSL is strictly designed for TCP). This however
> > makes some changes that many DPI firewalls *might* not identify
> > OpenVPN traffic as SSL traffic. But as it's not really an
> > obfuscation which changes over time, it might still be possible to
> > block it if this kind of traffic is detected.
>
> > However, the obfsproxy project sounds very interesting. And it
> > should be possible to use obfsproxy (as it can talk like a SOCKS
> > proxy) with OpenVPN, by using the --socks-proxy argument. But I'm
> > not aware of any openvpn services providing obfsproxy services in
> > conjunction with OpenVPN.
>
>
> > kind regards,
>
> > David Sommerseth
>
> -------------------------------------------------------------------------=
-----
> Try before you buy =3D See our experts in action!
> The most comprehensive online learning library for Microsoft developers
> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
> Metro Style Apps, more. Free future releases when you subscribe now!
> http://p.sf.net/sfu/learndevnow-dev2
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk88/isACgkQwp2X7RmNIqMv1ACfXT8xpTLVNng2RsVSukurCWEt
gMQAoNxqob4FGdi60axCsSbz1Q6SVGOH
=3Dl436
-----END PGP SIGNATURE-----


--------------030406010609030102080102
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    -----BEGIN PGP SIGNED MESSAGE-----<br>
    Hash: SHA1<br>
    <br>
    Hi Jun,<br>
    <br>
    I would try David's obfsproxy + OpenVPN suggestion first and
    reconsider if that fails.<br>
    If we would add obfuscation into OpenVPN itself, we'd soon be in the
    same cat and mouse game as Tor, with the exception we don't have the
    same amount of developer interest to follow it through. So, I think
    keeping the obfuscation functionality would be challenging in the
    long run.<br>
    <br>
    - -- <br>
    Samuli Sepp&auml;nen<br>
    Community Manager<br>
    OpenVPN Technologies, Inc<br>
    <br>
    irc freenode net: mattock<br>
    <br>
    <br>
    <span style="white-space: pre;">&gt; Hi David,<br>
      &gt;<br>
      &gt; I replied to you directly, maybe it got caught in your spam
      filter?<br>
      &gt;<br>
      &gt; Anyone else has some thoughts about developing an
      obfsproxy-style<br>
      &gt; component for OpenVPN?<br>
      &gt;<br>
      &gt; Best,<br>
      &gt;<br>
      &gt; Jun.<br>
      &gt;<br>
      &gt; On 13/02/2012 13:09, David Sommerseth wrote:<br>
      &gt; &gt; On 13/02/12 13:59, Jun Matsushita wrote:<br>
      &gt; &gt;&gt; This is my first post in this list. As probably a
      lot of you<br>
      &gt; &gt;&gt; heard, Iran has stepped up its filtering by
      apparently blocking<br>
      &gt; &gt;&gt; SSL/TLS using DPI. This is a good read about what's
      happening<br>
      &gt; &gt;&gt; <a class="moz-txt-link-freetext" href="http://news.ycombinator.com/item?id=3575029">http://news.ycombinator.com/item?id=3575029</a>. As
      these statistics<br>
      &gt; &gt;&gt; from TOR attest<br>
      &gt; &gt;&gt;
<a class="moz-txt-link-freetext" href="https://metrics.torproject.org/users.html?graph=direct-users&amp;start=2012-01-12&amp;end=2012-02-12&amp;country=ir&amp;events=on&amp;dpi=72#direct-users">https://metrics.torproject.org/users.html?graph=direct-users&amp;start=2012-01-12&amp;end=2012-02-12&amp;country=ir&amp;events=on&amp;dpi=72#direct-users</a><br>
      &gt;<br>
      &gt; &gt;&gt;<br>
      &gt;<br>
      &gt; &gt; the impact has been immediate and surely concerns the
      majority of<br>
      &gt; &gt; tools<br>
      &gt; &gt;&gt; out there.<br>
      &gt;<br>
      &gt; &gt;&gt; Does OpenVPN allow the use of some form of
      Obfuscation (such as<br>
      &gt; &gt;&gt; the one TOR is testing now and seem to work from
      within Iran<br>
      &gt; &gt;&gt;
      <a class="moz-txt-link-freetext" href="https://www.torproject.org/projects/obfsproxy-instructions.html.en">https://www.torproject.org/projects/obfsproxy-instructions.html.en</a>)?<br>
      &gt;<br>
      &gt; &gt;&gt; Anyone has thoughts about this or would be
      interested in<br>
      &gt; &gt;&gt; discussing the matter?<br>
      &gt;<br>
      &gt;<br>
      &gt; &gt; Hi Jun,<br>
      &gt;<br>
      &gt; &gt; OpenVPN uses SSL under the hood. But it does some tricks
      to allow<br>
      &gt; &gt; SSL over UDP (SSL is strictly designed for TCP). This
      however<br>
      &gt; &gt; makes some changes that many DPI firewalls *might* not
      identify<br>
      &gt; &gt; OpenVPN traffic as SSL traffic. But as it's not really
      an<br>
      &gt; &gt; obfuscation which changes over time, it might still be
      possible to<br>
      &gt; &gt; block it if this kind of traffic is detected.<br>
      &gt;<br>
      &gt; &gt; However, the obfsproxy project sounds very interesting.
      And it<br>
      &gt; &gt; should be possible to use obfsproxy (as it can talk like
      a SOCKS<br>
      &gt; &gt; proxy) with OpenVPN, by using the --socks-proxy
      argument. But I'm<br>
      &gt; &gt; not aware of any openvpn services providing obfsproxy
      services in<br>
      &gt; &gt; conjunction with OpenVPN.<br>
      &gt;<br>
      &gt;<br>
      &gt; &gt; kind regards,<br>
      &gt;<br>
      &gt; &gt; David Sommerseth<br>
      &gt;<br>
      &gt;
------------------------------------------------------------------------------<br>
      &gt; Try before you buy = See our experts in action!<br>
      &gt; The most comprehensive online learning library for Microsoft
      developers<br>
      &gt; is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5,
      CSS3, MVC3,<br>
      &gt; Metro Style Apps, more. Free future releases when you
      subscribe now!<br>
      &gt; <a class="moz-txt-link-freetext" href="http://p.sf.net/sfu/learndevnow-dev2">http://p.sf.net/sfu/learndevnow-dev2</a><br>
      &gt; _______________________________________________<br>
      &gt; Openvpn-devel mailing list<br>
      &gt; <a class="moz-txt-link-abbreviated" href="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a><br>
      &gt; <a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a></span><br>
    <br>
    -----BEGIN PGP SIGNATURE-----<br>
    Version: GnuPG v1.4.11 (GNU/Linux)<br>
    Comment: Using GnuPG with Mozilla - <a class="moz-txt-link-freetext" href="http://enigmail.mozdev.org/">http://enigmail.mozdev.org/</a><br>
    <br>
    iEYEARECAAYFAk88/isACgkQwp2X7RmNIqMv1ACfXT8xpTLVNng2RsVSukurCWEt<br>
    gMQAoNxqob4FGdi60axCsSbz1Q6SVGOH<br>
    =l436<br>
    -----END PGP SIGNATURE-----<br>
    <br>
  </body>
</html>

--------------030406010609030102080102--

