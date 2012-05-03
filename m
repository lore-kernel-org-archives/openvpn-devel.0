Message-ID: <4FA26565.1010308@...515...>
Date: Thu, 03 May 2012 14:00:53 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAAhp1KAp8DDJvgE9CTDST8HEGO4HTiMDmv88sTMpNxtWptyX+g@...278...>
	<CAOazyz35GLCBFFBfZe8KfXZerozZt3ULYD03mFtbhkS6ruxWDg@...278...>
	<CAAhp1KAyH3MkeAn7YS_E1474mUbjzTMeqztFNmc-RKD6JZgTyw@...278...>
	<CAAhp1KCJBqZfjKTRC28wk6g5Bkj=-8cP_oe--cY+cJ82-paNsw@...278...>
	<20120503071459.GM1359@...1296...>
	<CAAhp1KCovS4w-+tvPeaHA8xW8v4+KKmCD+Nt2XVjmkKdSuJG4g@...278...>
In-Reply-To: <CAAhp1KCovS4w-+tvPeaHA8xW8v4+KKmCD+Nt2XVjmkKdSuJG4g@...278...>
Content-Type: multipart/alternative;
	boundary="------------090409030105080702030703"
Subject: Re: [Openvpn-devel] Does OpenVPN Support Unicode Username and
	Password
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gauri Bhave <gaurib123@...277...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------090409030105080702030703
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Access Server and OpenVPN Connect client are commercial offerings based
on the OpenVPN 2.1.x tree. As such, they lack many of the features that
came in later community versions (2.2.x+). I'd guess they don't support
UTF-8, either.

I would use OpenVPN 2.3-alpha1 as it should be very stable and has most
of the latest features. You can use the with Access Server, too.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



> Well that's the legacy that i got from the previous developer. So just
> wanted to know if it supports UTF8. And it will really help if you can
> point out the exact version's of OpenVPN access server and OpenVPN
> connect client which support UTF8 username's and Passwords.
>
> Thanks
> Gauri Bhave
>
> On Thu, May 3, 2012 at 12:44 PM, Gert Doering <gert@...1296...
> <mailto:gert@...1296...>> wrote:
>
>     Hi,
>
>     On Thu, May 03, 2012 at 12:14:28PM +0530, Gauri Bhave wrote:
>     > Can you tell me which version of openvpn started supporting utf8.
>     I am
>     > using openvpn-2.1_rc15 but all my utf8 characters get converted
>     to '_'
>     > (underscores), when i see the log on the server side and AD gives
>     me an
>     > error authentication failed.
>
>     2.3_alpha1
>
>     (Just as a side remark - I don't understand why anyone would want
>     to use
>     a release *candidate* of something that has been properly released
>     over
>     3 years(!) ago - and the 2.1 train is now up to 2.1.4, and there is
>     2.2.2 as well...)
>
>     gert
>
>     --
>     USENET is *not* the non-clickable part of WWW!
>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
>     //www.muc.de/~gert/ <http://www.muc.de/%7Egert/>
>     Gert Doering - Munich, Germany=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>     gert@...1296... <mailto:gert@...1296...>
>     fax: +49-89-35655025=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20
>      gert@...1297...
>     <mailto:gert@...1297...>
>
>



--------------090409030105080702030703
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Access Server and OpenVPN Connect client are commercial offerings
    based on the OpenVPN 2.1.x tree. As such, they lack many of the
    features that came in later community versions (2.2.x+). I'd guess
    they don't support UTF-8, either.<br>
    <br>
    I would use OpenVPN 2.3-alpha1 as it should be very stable and has
    most of the latest features. You can use the with Access Server,
    too.<br>
    <pre class="moz-signature" cols="72">-- 
Samuli Sepp&auml;nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock</pre>
    <br>
    <br>
    <blockquote
cite="mid:CAAhp1KCovS4w-+tvPeaHA8xW8v4+KKmCD+Nt2XVjmkKdSuJG4g@...278..."
      type="cite">Well that's the legacy that i got from the previous
      developer. So just wanted to know if it supports UTF8. And it will
      really help if you can point out the exact version's of OpenVPN
      access server and OpenVPN connect client which support UTF8
      username's and Passwords.<br>
      <br>
      Thanks<br>
      Gauri Bhave<br>
      <br>
      <div class="gmail_quote">On Thu, May 3, 2012 at 12:44 PM, Gert
        Doering <span dir="ltr">&lt;<a moz-do-not-send="true"
            href="mailto:gert@...1296..." target="_blank">gert@...1296...</a>&gt;</span>
        wrote:<br>
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
          <div><br>
            On Thu, May 03, 2012 at 12:14:28PM +0530, Gauri Bhave wrote:<br>
            &gt; Can you tell me which version of openvpn started
            supporting utf8. I am<br>
            &gt; using openvpn-2.1_rc15 but all my utf8 characters get
            converted to '_'<br>
            &gt; (underscores), when i see the log on the server side
            and AD gives me an<br>
            &gt; error authentication failed.<br>
            <br>
          </div>
          2.3_alpha1<br>
          <br>
          (Just as a side remark - I don't understand why anyone would
          want to use<br>
          a release *candidate* of something that has been properly
          released over<br>
          3 years(!) ago - and the 2.1 train is now up to 2.1.4, and
          there is<br>
          2.2.2 as well...)<br>
          <span><font color="#888888"><br>
              gert<br>
              <br>
              --<br>
              USENET is *not* the non-clickable part of WWW!<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              //<a moz-do-not-send="true"
                href="http://www.muc.de/%7Egert/" target="_blank">www.muc.de/~gert/</a><br>
              Gert Doering - Munich, Germany &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              <a moz-do-not-send="true"
                href="mailto:gert@...1296..." target="_blank">gert@...1296...</a><br>
              fax: +49-89-35655025 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<a
                moz-do-not-send="true"
                href="mailto:gert@...1297..."
                target="_blank">gert@...1297...</a><br>
            </font></span></blockquote>
      </div>
      <br>
    </blockquote>
    <br>
    <br>
  </body>
</html>

--------------090409030105080702030703--

