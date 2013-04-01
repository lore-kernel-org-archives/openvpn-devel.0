MIME-Version: 1.0
In-Reply-To: <20130401184834.GE428@...1296...>
References: <1364762609-30320-1-git-send-email-arne@...1227...>
	<20130401111231.GD428@...1296...>
	<CAEsd45RW-ueAjEJS5PkecX=MuxLdBXA3uJceyVL6=wrvE9xoeA@...278...>
	<20130401184834.GE428@...1296...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Mon, 1 Apr 2013 15:57:51 -0400
Message-ID: <CAEsd45RkiWG0F9st=s-SE0SW428yE-bEFL6WBMJBgXHTjYwXQA@...278...>
Content-Type: multipart/alternative; boundary=f46d043c817a8eb6b004d9520b40
Subject: Re: [Openvpn-devel] building on OSX (for Tunnelblick) (was: [PATCH]
 Add support of utun devices under Mac OS X)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, Harold Molina-Bulla <h.molina@...277...>

--f46d043c817a8eb6b004d9520b40
Content-Type: text/plain; charset=UTF-8

On Mon, Apr 1, 2013 at 2:48 PM, Gert Doering <gert@...1296...> wrote:

> On Mon, Apr 01, 2013 at 09:26:04AM -0400, Jonathan K. Bullard wrote:
> > I don't have an opinion about including it in 2.3.2 vs. 2.4 -- I still
> > can't get anything after 2.3alpha1 to build properly for Tunnelblick!
>
> Uh.  I've seen some issues reported by you, but I thought it had been
> resolved in time for 2.3_RC and 2.3.0 - since we're at 2.3.1 now, I
> really want to see this fixed :-)
>
> So what is still breaking for you?
>
> (I'm especially surprised since I know Arne is building and testing on
> OSX, so it *should* work - but maybe it's "it works on 10.7 and 10.8,
> but fails on 10.6", which we might have overlooked as our pool of OSX
> machines with various OS releases to build on is a bit limited - how
> do other open source projects handle this??)
>

Thanks for your inquiry.

Tunnelblick is still being built on OS X 10.6.8 with Xcode 3.2.2 because it
still supports PowerPC, which later versions of Xcode (which are required
for use on 10.7+) don't support. (For simplicity, Tunnelblick and its
dependencies are all built as a single Xcode project. Tunnelblick usually
includes at least two or three versions of OpenVPN, and lets the user
select which version they want to use with a couple of clicks, but of
course it is limited to the versions that we can build!)

I doubt that the issues are in OpenVPN itself, or its build system. I think
I couldn't get it working because of my unfamiliarity with make and the
toolset that is required to build OpenVPN. As I remember:

   - The problems happen for 2.3alpha2 but not 2.3alpha1, and I finally
   figured out they were triggered not by the major build-system changes, but
   by the initial patch that added PolarSSL.
   - The problems were in getting openvpn to static link with lzo and
   openssl. (There may have been a similar issue with pkcs11-helper, but it is
   broken in Tunnelblick and I later found out that it shouldn't be static
   linked, so that wasn't a major concern.)

Harold Molina-Bulla has taken over the effort to get Tunnelblick building
with OpenVPN 2.3. I've added him as a cc: to this thread.

--f46d043c817a8eb6b004d9520b40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2013 at 2:48 PM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

On Mon, Apr 01, 2013 at 09:26:04AM -0400, Jonathan K. Bullard wrote:<br>
&gt; I don&#39;t have an opinion about including it in 2.3.2 vs. 2.4 -- I s=
till<br>
&gt; can&#39;t get anything after 2.3alpha1 to build properly for Tunnelbli=
ck!<br>
<br>
Uh. =C2=A0I&#39;ve seen some issues reported by you, but I thought it had b=
een<br>
resolved in time for 2.3_RC and 2.3.0 - since we&#39;re at 2.3.1 now, I<br>
really want to see this fixed :-)<br>
<br>
So what is still breaking for you?<br>
<br>
(I&#39;m especially surprised since I know Arne is building and testing on<=
br>
OSX, so it *should* work - but maybe it&#39;s &quot;it works on 10.7 and 10=
.8,<br>
but fails on 10.6&quot;, which we might have overlooked as our pool of OSX<=
br>
machines with various OS releases to build on is a bit limited - how<br>
do other open source projects handle this??)<br></blockquote><div><br></div=
><div>Thanks for your inquiry.</div><div><br></div><div>Tunnelblick is stil=
l being built on OS X 10.6.8 with Xcode 3.2.2 because it still supports Pow=
erPC, which later versions of Xcode (which are required for use on 10.7+) d=
on&#39;t support. (For simplicity, Tunnelblick and its dependencies are all=
 built as a single Xcode project. Tunnelblick usually includes at least two=
 or three versions of OpenVPN, and lets the user select which version they =
want to use with a couple of clicks, but of course it is limited to the ver=
sions that we can build!)</div>

<div><br></div><div>I doubt that the issues are in OpenVPN itself, or its b=
uild system. I think I couldn&#39;t get it working because of my unfamiliar=
ity with make and the toolset that is required to build OpenVPN. As I remem=
ber:</div>

<div><ul><li>The problems happen for 2.3alpha2 but not 2.3alpha1, and I fin=
ally figured out they were triggered not by the major build-system changes,=
 but by the initial patch that added PolarSSL.</li><li>The problems were in=
 getting openvpn to static link with lzo and openssl. (There may have been =
a similar issue with pkcs11-helper, but it is broken in Tunnelblick and I l=
ater found out that it shouldn&#39;t be static linked, so that wasn&#39;t a=
 major concern.)</li>

</ul></div><div>Harold Molina-Bulla has taken over the effort to get Tunnel=
blick building with OpenVPN 2.3. I&#39;ve added him as a cc: to this thread=
.</div><div><br></div></div>

--f46d043c817a8eb6b004d9520b40--

