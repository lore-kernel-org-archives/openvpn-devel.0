From: <openvpn@...1315...>
Date: Wed, 03 Mar 2010 09:57:10 -0600
Message-id: <1267631830111647500@...1315...>
In-reply-to: <1267630295.5048.3@...1207...>
References: <1267588345473303500@...1315...> <4B8E2070.6050208@...1299...>
	<1267630295.5048.3@...1207...>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="===axigen=4301305681651379255990641248151431211652=axigen==="
Subject: Re: [Openvpn-devel] Erratic TCP Throughput
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

This is a MIME message. You may need a MIME compliant mail user agent.
--===axigen=4301305681651379255990641248151431211652=axigen===
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

=20

This is more my bet, because my question wasn't very clear ... I require a =
proxy server during "normal" operation, but for this data throughput test I=
 had no proxy server, rather a "direct" connection.

=20

Thoughts?

=20

Thanks!


On Wed, Mar 3, 2010 09:31 AM, "Karl O. Pinc" <kop@...1206...> wrote:


>=20
On 03/03/2010 02:40:16 AM, Jason Haar wrote:
> > On 03/03/2010 04:52 PM, openvpn@...1315... wrote:
> > >
> > > 1) Without OpenVPN - consistent performance, ~ 70 Mbps total
> > > throughput (on a 100 Mb LAN).
>=20
> > > 2) With OpenVPN - very consistent performance, sometimes fine,=20
> > other
> > > times very poor. ~ 70 Mbps total throughput (on a 100 Mb LAN), but
> > > bounces around a lot.
>=20
> > So what you're saying is that on a ~70Mbs network you sometimes see
> > ~70Mbs via "openvpn-via-proxy-server" and sometimes you don't? As the
> > performance of openvpn varies - and I assume you know the client and
> > server aren't the bottleneck - then that leaves....?
> >=20
> > The proxy! :-)=20
>=20
> Or problems with tunneling tcp inside tcp which you can trace
> back via this thread:
>=20
> http://article.gmane.org/gmane.network.openvpn.user/29183
>=20
>=20
>=20
> Karl <kop@...1206...>
> Free Software: "You don't pay back, you pay forward."
> -- Robert A. Heinlein
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Download Intel=C2=AE Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20=

--===axigen=4301305681651379255990641248151431211652=axigen===
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style id=3D"axi-htmleditor-style" type=3D"text/css">p { margin=
: 0px; }</style></head><body style=3D"font-size: 10pt; font-family: Arial; =
background-image: none; background-repeat: repeat; background-attachment: f=
ixed;"><P>Hi,</P>
<P>&nbsp;</P>
<P>This is more my bet, because my question wasn't very clear ... I require=
 a proxy server during "normal" operation, but for this data throughput tes=
t I had no proxy server, rather a "direct" connection.</P>
<P>&nbsp;</P>
<P>Thoughts?</P>
<P>&nbsp;</P>
<P>Thanks!</P>
<P><BR><BR>On Wed, Mar 3, 2010 09:31 AM, "Karl&nbsp;O.&nbsp;Pinc"&nbsp;&lt;=
kop@...1206...&gt; wrote:<BR></P>
<BLOCKQUOTE style=3D"BORDER-LEFT: rgb(0,0,204) 2px solid; PADDING-LEFT: 4px=
; MARGIN-LEFT: 16px">
<DIV style=3D"FONT-FAMILY: monospace; FONT-SIZE: 10pt">On 03/03/2010 02:40:=
16 AM, Jason Haar wrote:<BR>&gt; On 03/03/2010 04:52 PM,<A href=3D"mailto:%=
20openvpn@...1315..." target=3D_blank> openvpn@...1315...</A> wrote:<BR>&gt=
; &gt;<BR>&gt; &gt; 1) Without OpenVPN - consistent performance, ~ 70 Mbps =
total<BR>&gt; &gt; throughput (on a 100 Mb LAN).<BR><BR>&gt; &gt; 2) With O=
penVPN - very consistent performance, sometimes fine, <BR>&gt; other<BR>&gt=
; &gt; times very poor. ~ 70 Mbps total throughput (on a 100 Mb LAN), but<B=
R>&gt; &gt; bounces around a lot.<BR><BR>&gt; So what you're saying is that=
 on a ~70Mbs network you sometimes see<BR>&gt; ~70Mbs via "openvpn-via-prox=
y-server" and sometimes you don't? As the<BR>&gt; performance of openvpn va=
ries - and I assume you know the client and<BR>&gt; server aren't the bottl=
eneck - then that leaves....?<BR>&gt; <BR>&gt; The proxy! :-) <BR><BR>Or pr=
oblems with tunneling tcp inside tcp which you can trace<BR>back via this t=
hread:<BR><BR><A href=3D"http://server:8080/redir.hsp?url=3D%68%74%74%70%3A=
%2F%2F%61%72%74%69%63%6C%65%2E%67%6D%61%6E%65%2E%6F%72%67%2F%67%6D%61%6E%65=
%2E%6E%65%74%77%6F%72%6B%2E%6F%70%65%6E%76%70%6E%2E%75%73%65%72%2F%32%39%31=
%38%33" target=3D_blank>http://article.gmane.org/gmane.network.openvpn.user=
/29183</A><BR><BR><BR><BR>Karl &lt;<A href=3D"mailto:kop@...1206..." target=
=3D_blank>kop@...1206...</A>&gt;<BR>Free Software: "You don't pay back, you=
 pay forward."<BR>-- Robert A. Heinlein<BR><BR><BR>------------------------=
------------------------------------------------------<BR>Download Intel&am=
p;#174; Parallel Studio Eval<BR>Try the new software tools for yourself. Sp=
eed compiling, find bugs<BR>proactively, and fine-tune applications for par=
allel performance.<BR>See why Intel Parallel Studio got high marks during b=
eta.<BR><A href=3D"http://server:8080/redir.hsp?url=3D%68%74%74%70%3A%2F%2F=
%70%2E%73%66%2E%6E%65%74%2F%73%66%75%2F%69%6E%74%65%6C%2D%73%77%2D%64%65%76=
" target=3D_blank>http://p.sf.net/sfu/intel-sw-dev</A><BR>_________________=
______________________________<BR>Openvpn-devel mailing list<BR><A href=3D"=
mailto:Openvpn-devel@lists.sourceforge.net" target=3D_blank>Openvpn-devel@...465...=
ists.sourceforge.net</A><BR><A href=3D"http://server:8080/redir.hsp?url=3D%=
68%74%74%70%73%3A%2F%2F%6C%69%73%74%73%2E%73%6F%75%72%63%65%66%6F%72%67%65%=
2E%6E%65%74%2F%6C%69%73%74%73%2F%6C%69%73%74%69%6E%66%6F%2F%6F%70%65%6E%76%=
70%6E%2D%64%65%76%65%6C" target=3D_blank>https://lists.sourceforge.net/list=
s/listinfo/openvpn-devel</A><BR></DIV></BLOCKQUOTE></body></html>=

--===axigen=4301305681651379255990641248151431211652=axigen===--


