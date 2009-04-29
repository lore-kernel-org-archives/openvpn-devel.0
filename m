MIME-Version: 1.0
In-Reply-To: <49F81332.7020402@...1212...>
References: <m3prf3sag3.fsf@...1213...>
	<9e0cf0bf0904231043x61f0776dm4b463b113fa5ff33@...278...>
	<49F6BDDB.1020200@...1212...>
	<9e0cf0bf0904280129i6810505by2545ef210709466e@...278...>
	<49F6C33B.8000903@...1212...>
	<9e0cf0bf0904290140v7ff8bedeyb026817ceed3dc64@...278...>
	<49F81332.7020402@...1212...>
Date: Wed, 29 Apr 2009 11:56:26 +0300
Message-ID: <9e0cf0bf0904290156w16316ee0i9e1631305d6ee0bf@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Content-Type: multipart/mixed; boundary=001636c5a8d128d3cc0468adc1b7
Subject: Re: [Openvpn-devel] rc15 rpm spec glitches
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: aleksandar@...1212..., James Yonan <james@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--001636c5a8d128d3cc0468adc1b7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Oh... it was missing.

James,
Attached is a fix for rpm spec (pkcs11) and the inclusion of the
management directory.

Still waiting for merge of my previous work.

Alon.

On 4/29/09, Aleksandar Ivanisevic <aleksandar@...1212...> wrote:
>
>  because this dir doesn't exist any more, at least not in
> openvpn-2.1_rc15.tar.gz, so the build fails.
>
>
>  Alon Bar-Lev wrote:
>
> > Why did you remove the management from doc?
> >
> > On 4/28/09, Aleksandar Ivanisevic <aleksandar@...1212...> wrote:
> >
> > >  ok, attached
> > >
> > >
> > >  Alon Bar-Lev wrote:
> > >
> > >
> > > > Yes, I don't think it is maintained.
> > > >
> > > > Please send uniform diff.
> > > >
> > > > Use: "diff -urNp"
> > > >
> > > >
> > > >
> > >
> > >
> > >
> >
> >
>

--001636c5a8d128d3cc0468adc1b7
Content-Type: text/x-patch; charset=US-ASCII; name="openvpn-rpm.diff"
Content-Disposition: attachment; filename="openvpn-rpm.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fu3sk3ei

SW5kZXg6IG9wZW52cG4uc3BlYy5pbgo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBvcGVudnBuLnNwZWMuaW4JKHJl
dmlzaW9uIDQyMzcpCisrKyBvcGVudnBuLnNwZWMuaW4JKHdvcmtpbmcgY29weSkKQEAgLTUyLDgg
KzUyLDEwIEBACiAleyE/d2l0aG91dF9wYW06QnVpbGRSZXF1aXJlczogcGFtLWRldmVsfQogJXsh
P3dpdGhvdXRfcGFtOlJlcXVpcmVzOiAgICAgIHBhbX0KIAorJWlmICIle192ZW5kb3J9IiA9PSAi
TWFuZHJha2VTb2Z0IiB8fCAiJXtfdmVuZG9yfSIgPT0gInN1c2UiIHx8ICIle192ZW5kb3J9IiA9
PSAicGMiCiAleyE/d2l0aF9wa2NzMTE6QnVpbGRSZXF1aXJlczogcGtjczExLWhlbHBlci1kZXZl
bH0KICV7IT93aXRoX3BrY3MxMTpSZXF1aXJlczogICAgICBwa2NzMTEtaGVscGVyfQorJWVuZGlm
IAogCiAjCiAjIERlc2NyaXB0aW9uCkBAIC0yMjYsNiArMjI4LDkgQEAKICVkb2MgY29udHJpYi8g
ZWFzeS1yc2EvIG1hbmFnZW1lbnQvIHNhbXBsZS0qLyBwbHVnaW4vUkVBRE1FLioKIAogJWNoYW5n
ZWxvZworKiBUdWUgQXByIDI4IDIwMDkgQWxla3NhbmRhciBJdmFuaXNldmljIDxhbGVrc2FuZGFy
QGl2YW5pc2V2aWMuZGU+CistIFJIRUwgY29tcGF0aWJpbGl0eSBmaXhlcworCiAqIFRodSBEZWMg
MTQgMjAwNiBBbG9uIEJhci1MZXYKIC0gQWRkZWQgd2l0aF9wa2NzMTEKIApJbmRleDogTWFrZWZp
bGUuYW0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQotLS0gTWFrZWZpbGUuYW0JKHJldmlzaW9uIDQyMzcpCisrKyBNYWtl
ZmlsZS5hbQkod29ya2luZyBjb3B5KQpAQCAtNDgsNiArNDgsNyBAQAogCXRhcC13aW4zMiBcCiAJ
Y29udHJpYiBcCiAJZGVidWcgXAorCW1hbmFnZW1lbnQgXAogCXBsdWdpbgogCiBTVUJESVJTID0g
XAo=
--001636c5a8d128d3cc0468adc1b7--

