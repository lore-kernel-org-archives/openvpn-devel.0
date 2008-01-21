Message-ID: <479474C2.5090308@...1028...>
Date: Mon, 21 Jan 2008 11:32:34 +0100
From: Peter Warasin <peter@...1028...>
MIME-Version: 1.0
References: <93661e2e0710270421s36c345b4o8b3b94a95b4ed0e6@...278...>
In-Reply-To: <93661e2e0710270421s36c345b4o8b3b94a95b4ed0e6@...278...>
Content-Type: multipart/mixed; boundary="------------070604070200060903090201"
Subject: Re: [Openvpn-devel] multi-homed udp-based OpenVPN Server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kate Kretz <kate.kretz@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070604070200060903090201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi

Kate Kretz wrote:
> > we tried to use OpenVPN Server on two-nic (both are internet-connected)
> > server.
> > udp packets always go out on default gateway, even if they came from
> > another nic.

I have the same problem.
Was not able to go more in depth into this problem, but i will (need to)
soon.
In the meantime, i thought about using --float on the clients. This should
work.

peter

-- 
:: e n d i a n
:: open source - open minds

:: peter warasin
:: http://www.endian.com   :: peter@...1028...

--------------070604070200060903090201
Content-Type: text/x-vcard; charset=utf-8;
 name="peter.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="peter.vcf"

begin:vcard
fn:Peter Warasin
n:;Peter Warasin
org:Endian GmbH/Srl
adr:;;Pillhof 47;Frangart/Frangarto;BZ;I-39010;Italien/Italia
email;internet:peter@...1028...
tel;work:+39 0471 631763
tel;fax:+39 0471 631764
x-mozilla-html:FALSE
url:http://www.endian.com
version:2.1
end:vcard


--------------070604070200060903090201--

