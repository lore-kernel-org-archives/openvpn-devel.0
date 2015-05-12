From: Lisa Minogue <lminogue@...1892...>
Message-ID: <22326556.492960.1431441687378.JavaMail.root@...1893...>
In-Reply-To: <CAEsd45ROOw7UBOUTw8T7J_DjiJW-iJ-fo2YyuE5dt9X4VaWyKg@...278...>
References: <13470069.462428.1431417550257.JavaMail.root@...1893...>
	<5551BE33.2010208@...1227...>
	<4001174.479134.1431430060517.JavaMail.root@...1893...>
	<CAEsd45ROOw7UBOUTw8T7J_DjiJW-iJ-fo2YyuE5dt9X4VaWyKg@...278...>
MIME-Version: 1.0
Date: Tue, 12 May 2015 16:41:27 +0200 (CEST)
Subject: Re: [Openvpn-devel] Request peer review of modified OpenVPN client
 software
Reply-To: Lisa Minogue <lminogue@...1892...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> "Jonathan K. Bullard" <jkbullard@...277...> wrote:
>
> The openvpn_xorpatch which as introduced and discussed in this thread does have some vulnerabilities.
>
> Most of the vulnerabilities are null pointer dereferences or other errors when parsing the "scramble" option or are triggered by unlikely values for its parameters. However, one is a potential buffer overflow
> which can occur while the VPN is active and could potentially be triggered by carefully constructed traffic.

Thanks Jonathan for your feedback.

I've a different question for you. What about using stunnel4 with OpenVPN?

I've seen a situation in which a user opens a stunnel4 connection in Linux (without root) as in the following:

stunnel filename.ssl

In a new terminal window, the user, as root, types the following command to connect to an OpenVPN server:

sudo openvpn filename.ovpn

I was told the above method achieves the same goal as using the OpenVPN_XOR-patch method, i.e. preventing deep packet inspection carried out by the Great Firewall.

But does the stunnel4+openvpn combo method have security vulnerabilities? (Last I checked, stunnel4 is available in many Linux distros.)

Regards.

Lisa
-----------------------------------------------------
Mail.be, WebMail and Virtual Office
http://www.mail.be

