Message-ID: <93661e2e0711040332x31c8add2g6ed8d6ce285b470b@...278...>
Date: Sun, 4 Nov 2007 16:32:55 +0500
From: "Kate Kretz" <kate.kretz@...277...>
In-Reply-To: <20071101104459.GA4699@...1017...>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_19279_33119346.1194175975794"
References: <20071101101408.GA3572@...1017...>
	<469588034.20071101133206@...1022...>
	<20071101104459.GA4699@...1017...>
Subject: Re: [Openvpn-devel] DHCP Renew failing on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

------=_Part_19279_33119346.1194175975794
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

probably You'll want to disable auto configuring NIC with 169.254.X.X

read about IPAutoconfigurationEnabled at
http://support.microsoft.com/kb/220874


On 11/1/07, Michele Baldessari <michele-lists@...1016...> wrote:
>
> Hi Alexey,
>
> * Alexey Vdovin (admin@...1022...) wrote:
> > Most probably it happens when DHCP lase is expires and client trys
> > renew DHCP address.
> >
> > Check DHCP lease lifetime, try decrease it to reproduce the issue.
>
> I've sniffed the network (although not in a problematic case) and I
> sometimes I'm able to see the DHCP NACK message, but then the client
> correctly asks for the new lease and receives the subsequent ACK.
>
> I'll toy with the lease time option (the default lease time is a year
> per default). I'll see if that helps.
>
> thanks,
> Michele
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.6 (GNU/Linux)
>
> iD8DBQFHKa4rofbulCQLTD0RAjudAJ0XrIVBzwcJjABts8XiesspHZDU2QCbBQTP
> u1+cNAf3p2Gffhlkbk6L8OU=
> =Nhfr
> -----END PGP SIGNATURE-----
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

------=_Part_19279_33119346.1194175975794
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>probably You&#39;ll want to disable auto configuring NIC with 169.254.X.X</div>
<div>&nbsp;</div>
<div>read about IPAutoconfigurationEnabled at <a href="http://support.microsoft.com/kb/220874">http://support.microsoft.com/kb/220874</a><br><br>&nbsp;</div>
<div><span class="gmail_quote">On 11/1/07, <b class="gmail_sendername">Michele Baldessari</b> &lt;<a href="mailto:michele-lists@...1016...">michele-lists@...1016...</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Alexey,<br><br>* Alexey Vdovin (<a href="mailto:admin@...1022...">admin@...1022...</a>) wrote:<br>&gt; Most probably it happens when DHCP lase is expires and client trys
<br>&gt; renew DHCP address.<br>&gt;<br>&gt; Check DHCP lease lifetime, try decrease it to reproduce the issue.<br><br>I&#39;ve sniffed the network (although not in a problematic case) and I<br>sometimes I&#39;m able to see the DHCP NACK message, but then the client
<br>correctly asks for the new lease and receives the subsequent ACK.<br><br>I&#39;ll toy with the lease time option (the default lease time is a year<br>per default). I&#39;ll see if that helps.<br><br>thanks,<br>Michele
<br><br>-----BEGIN PGP SIGNATURE-----<br>Version: GnuPG v1.4.6 (GNU/Linux)<br><br>iD8DBQFHKa4rofbulCQLTD0RAjudAJ0XrIVBzwcJjABts8XiesspHZDU2QCbBQTP<br>u1+cNAf3p2Gffhlkbk6L8OU=<br>=Nhfr<br>-----END PGP SIGNATURE-----<br><br>
-------------------------------------------------------------------------<br>This SF.net email is sponsored by: Splunk Inc.<br>Still grepping through log files to find problems?&nbsp;&nbsp;Stop.<br>Now Search log events and configuration files using AJAX and a browser.
<br>Download your FREE copy of Splunk now &gt;&gt; <a href="http://get.splunk.com/">http://get.splunk.com/</a><br>_______________________________________________<br>Openvpn-devel mailing list<br><a href="mailto:Openvpn-devel@lists.sourceforge.net">
Openvpn-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a><br><br></blockquote></div><br>

------=_Part_19279_33119346.1194175975794--

