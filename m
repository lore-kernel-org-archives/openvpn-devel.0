MIME-Version: 1.0
In-Reply-To: <4FA27940.3080104@...1114...>
References: <CAAhp1KAp8DDJvgE9CTDST8HEGO4HTiMDmv88sTMpNxtWptyX+g@...278...>
	<CAOazyz35GLCBFFBfZe8KfXZerozZt3ULYD03mFtbhkS6ruxWDg@...278...>
	<CAAhp1KAyH3MkeAn7YS_E1474mUbjzTMeqztFNmc-RKD6JZgTyw@...278...>
	<CAAhp1KCJBqZfjKTRC28wk6g5Bkj=-8cP_oe--cY+cJ82-paNsw@...278...>
	<20120503071459.GM1359@...1296...>
	<CAAhp1KCovS4w-+tvPeaHA8xW8v4+KKmCD+Nt2XVjmkKdSuJG4g@...278...>
	<4FA27940.3080104@...1114...>
Date: Fri, 4 May 2012 12:08:19 +0530
Message-ID: <CAAhp1KBaH-f+9t0Y04GruOKDXTdvh=qsi6t8hJzhbXiWW+g0yQ@...278...>
From: Gauri Bhave <gaurib123@...277...>
Content-Type: multipart/alternative; boundary=047d7b33d5ca8bfa9904bf302a22
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

--047d7b33d5ca8bfa9904bf302a22
Content-Type: text/plain; charset=ISO-8859-1

Hi,

Thankyou for your reply. I was looking at the options available to support
UTF8. I do not want to use the commercial version.
So do you mean to say that the latest release of the community version of
OpenVPN supports UTF8 Usernames and Passwords?

Thanks & Regards
Gauri Bhave

On Thu, May 3, 2012 at 5:55 PM, David Sommerseth <
openvpn.list@...1114...> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 03/05/12 12:21, Gauri Bhave wrote:
> > Well that's the legacy that i got from the previous developer. So
> > just wanted to know if it supports UTF8. And it will really help if
> > you can point out the exact version's of OpenVPN access server and
> > OpenVPN connect client which support UTF8 username's and
> > Passwords.
>
> OpenVPN Access Server and OpenVPN Connect Client are the commercial
> offerings from OpenVPN Technologies.  We don't support them here, and
> the codebase there are somewhat different from the OpenVPN Community
> Edition we support here.  However, the Community Edition have all the
> features as the Access Server/Connect Client have - and some more.
>
> For the commercial support, please contact the company directly.
>
> Otherwise, feel free to dig into the information about the Community
> Edition of OpenVPN here:
>
> <https://community.openvpn.net/openvpn>
>
> There are some on-going works to update the Access Server and Connect
> Clients to a newer codebase, based upon the community version.
> However, there are no publicly known schedules for when or how this
> will happen.  And we on the community side are not involved into those
> decisions at all.
>
> Having all that said, there has been done a lot in the community
> edition to support UTF-8, especially on Windows.  If the commercial
> versions have pulled in that support or not, or have implemented
> something else; that we don't know anything about at all.  But I
> suspect that the Access Server and Connect Client is currently not
> UTF-8 capable on Windows.
>
> There should also be no issues using the Community Edition on the
> client side against an Access Server installation, if that is an
> alternative.
>
> I hope this answers your question better.
>
>
> kind regards,
>
> David Sommerseth
>
>
>
>
> > On Thu, May 3, 2012 at 12:44 PM, Gert Doering <gert@...1296...
> > <mailto:gert@...1296...>> wrote:
> >
> > Hi,
> >
> > On Thu, May 03, 2012 at 12:14:28PM +0530, Gauri Bhave wrote:
> >> Can you tell me which version of openvpn started supporting utf8.
> >> I am using openvpn-2.1_rc15 but all my utf8 characters get
> >> converted to '_' (underscores), when i see the log on the server
> >> side and AD gives
> > me an
> >> error authentication failed.
> >
> > 2.3_alpha1
> >
> > (Just as a side remark - I don't understand why anyone would want
> > to use a release *candidate* of something that has been properly
> > released over 3 years(!) ago - and the 2.1 train is now up to
> > 2.1.4, and there is 2.2.2 as well...)
> >
> > gert
> >
> > -- USENET is *not* the non-clickable part of WWW!
> >
> > //www.muc.de/~gert/ <http://www.muc.de/%7Egert/> <
> http://www.muc.de/%7Egert/> Gert Doering -
> > Munich, Germany gert@...1296... <mailto:gert@...1296...>
> > fax: +49-89-35655025 gert@...1297...
> > <mailto:gert@...1297...>
> >
> >
> >
> >
> >
> ------------------------------------------------------------------------------
> >
> >
> Live Security Virtual Conference
> > Exclusive live event will cover all the ways today's security and
> > threat landscape has changed and how IT managers can respond.
> > Discussions will include endpoint security, mobile security and the
> > latest in malware threats.
> > http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> >
> >
> >
> > _______________________________________________ Openvpn-devel
> > mailing list Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk+ieT4ACgkQDC186MBRfroaiwCfUNxdN7fRmgPx4Zphf1JkEmwu
> lKgAnR2E1MUZdU9qQLtaTvvt8uU+cDa3
> =ZgFK
> -----END PGP SIGNATURE-----
>

--047d7b33d5ca8bfa9904bf302a22
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>Thankyou for your reply. I was looking at the options available =
to support UTF8. I do not want to use the commercial version. <br>So do you=
 mean to say that the latest release of the community version of OpenVPN su=
pports UTF8 Usernames and Passwords?<br>
<br>Thanks &amp; Regards<br>Gauri Bhave<br><br><div class=3D"gmail_quote">O=
n Thu, May 3, 2012 at 5:55 PM, David Sommerseth <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:openvpn.list@...1114..." target=3D"_blank">openvpn.list@...1712...=
4...</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">-----BEGIN PGP SIGNED MESSAGE-----<br>
Hash: SHA1<br>
<div class=3D"im"><br>
On 03/05/12 12:21, Gauri Bhave wrote:<br>
&gt; Well that&#39;s the legacy that i got from the previous developer. So<=
br>
&gt; just wanted to know if it supports UTF8. And it will really help if<br>
&gt; you can point out the exact version&#39;s of OpenVPN access server and=
<br>
&gt; OpenVPN connect client which support UTF8 username&#39;s and<br>
&gt; Passwords.<br>
<br>
</div>OpenVPN Access Server and OpenVPN Connect Client are the commercial<b=
r>
offerings from OpenVPN Technologies. =A0We don&#39;t support them here, and=
<br>
the codebase there are somewhat different from the OpenVPN Community<br>
Edition we support here. =A0However, the Community Edition have all the<br>
features as the Access Server/Connect Client have - and some more.<br>
<br>
For the commercial support, please contact the company directly.<br>
<br>
Otherwise, feel free to dig into the information about the Community<br>
Edition of OpenVPN here:<br>
<br>
&lt;<a href=3D"https://community.openvpn.net/openvpn" target=3D"_blank">htt=
ps://community.openvpn.net/openvpn</a>&gt;<br>
<br>
There are some on-going works to update the Access Server and Connect<br>
Clients to a newer codebase, based upon the community version.<br>
However, there are no publicly known schedules for when or how this<br>
will happen. =A0And we on the community side are not involved into those<br>
decisions at all.<br>
<br>
Having all that said, there has been done a lot in the community<br>
edition to support UTF-8, especially on Windows. =A0If the commercial<br>
versions have pulled in that support or not, or have implemented<br>
something else; that we don&#39;t know anything about at all. =A0But I<br>
suspect that the Access Server and Connect Client is currently not<br>
UTF-8 capable on Windows.<br>
<br>
There should also be no issues using the Community Edition on the<br>
client side against an Access Server installation, if that is an<br>
alternative.<br>
<br>
I hope this answers your question better.<br>
<br>
<br>
kind regards,<br>
<br>
David Sommerseth<br>
<div class=3D"im"><br>
<br>
<br>
<br>
&gt; On Thu, May 3, 2012 at 12:44 PM, Gert Doering &lt;<a href=3D"mailto:ge=
rt@...1296...">gert@...1296...</a><br>
</div><div class=3D"im">&gt; &lt;mailto:<a href=3D"mailto:gert@...1296...">=
gert@...1296...</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; On Thu, May 03, 2012 at 12:14:28PM +0530, Gauri Bhave wrote:<br>
&gt;&gt; Can you tell me which version of openvpn started supporting utf8.<=
br>
&gt;&gt; I am using openvpn-2.1_rc15 but all my utf8 characters get<br>
&gt;&gt; converted to &#39;_&#39; (underscores), when i see the log on the =
server<br>
&gt;&gt; side and AD gives<br>
&gt; me an<br>
&gt;&gt; error authentication failed.<br>
&gt;<br>
&gt; 2.3_alpha1<br>
&gt;<br>
&gt; (Just as a side remark - I don&#39;t understand why anyone would want<=
br>
&gt; to use a release *candidate* of something that has been properly<br>
&gt; released over 3 years(!) ago - and the 2.1 train is now up to<br>
&gt; 2.1.4, and there is 2.2.2 as well...)<br>
&gt;<br>
&gt; gert<br>
&gt;<br>
&gt; -- USENET is *not* the non-clickable part of WWW!<br>
&gt;<br>
</div>&gt; //<a href=3D"http://www.muc.de/%7Egert/" target=3D"_blank">www.m=
uc.de/~gert/</a> &lt;<a href=3D"http://www.muc.de/%7Egert/" target=3D"_blan=
k">http://www.muc.de/%7Egert/</a>&gt; Gert Doering -<br>
&gt; Munich, Germany <a href=3D"mailto:gert@...1296...">gert@...1296...</a>=
 &lt;mailto:<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt;<br>
&gt; fax: +49-89-35655025 <a href=3D"mailto:gert@...1297...">gert@...1713...=
.</a><br>
&gt; &lt;mailto:<a href=3D"mailto:gert@...1297...">gert@...1297...</a>&gt;<=
br>
<div class=3D"im">&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; ----------------------------------------------------------------------=
--------<br>
&gt;<br>
&gt;<br>
Live Security Virtual Conference<br>
&gt; Exclusive live event will cover all the ways today&#39;s security and<=
br>
&gt; threat landscape has changed and how IT managers can respond.<br>
&gt; Discussions will include endpoint security, mobile security and the<br>
&gt; latest in malware threats.<br>
&gt; <a href=3D"http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/" =
target=3D"_blank">http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/=
</a><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________ Openvpn-devel<br>
&gt; mailing list <a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Op=
envpn-devel@lists.sourceforge.net</a><br>
&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel"=
 target=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-dev=
el</a><br>
<br>
</div>-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v1.4.11 (GNU/Linux)<br>
Comment: Using GnuPG with Mozilla - <a href=3D"http://enigmail.mozdev.org/"=
 target=3D"_blank">http://enigmail.mozdev.org/</a><br>
<br>
iEYEARECAAYFAk+ieT4ACgkQDC186MBRfroaiwCfUNxdN7fRmgPx4Zphf1JkEmwu<br>
lKgAnR2E1MUZdU9qQLtaTvvt8uU+cDa3<br>
=3DZgFK<br>
-----END PGP SIGNATURE-----<br>
</blockquote></div><br>

--047d7b33d5ca8bfa9904bf302a22--

