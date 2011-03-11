Message-ID: <4D7AADA0.6070201@...1299...>
Date: Sat, 12 Mar 2011 12:17:52 +1300
From: Jason Haar <Jason.Haar@...1299...>
MIME-Version: 1.0
References: <AANLkTi=gX2zHuk40P5RVtM8XmgZCp3V5_o20OeSy80N_@...278...>	<20110311090414.GE9835@...1296...>	<4D79ECC4.8010805@...1114...>	<AANLkTi=5kX-fweV=wzAR0e_mMpvBbNuKGkt0rNQVUZ5P@...278...>	<AANLkTimvV+iW_ZeF2PFZvFjNNRDwDwZUHzTxY_wY__qr@...278...>
	<AANLkTinfb7AZpdOj=-6=2fjpomzwTn2KWKCkvHF7VjMY@...278...>
In-Reply-To: <AANLkTinfb7AZpdOj=-6=2fjpomzwTn2KWKCkvHF7VjMY@...278...>
Subject: Re: [Openvpn-devel] openvpn protocol breaks proxies intercepting
 SSL ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 03/12/2011 10:34 AM, Vineet Kumar wrote:
> BlueCoat's ProxySG is one that runs tranparent SSL protocol detection
> and breaks if openvpn traffic is coming in via 443. This proxy is able
> to pass through other non-HTTP pure SSL traffic though and not just
> HTTPS.

A bit off-topic, but do you know if Skype works through that proxy?
Skype falls back to attempting connections over port 443 if it can't get
others to work, and as it is primarily a UDP-based product - like
openvpn - I've always wondered if their "port 443" traffic was true SSL
or just some other encrypted "skype protocol".

i.e. if an organization has a policied BlueCoat transparent HTTPS proxy,
and general egress filtering, does Skype work?


-- 
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +64 3 9635 377 Fax: +64 3 9635 417
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


