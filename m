Message-ID: <4D797BCF.4030506@...1299...>
Date: Fri, 11 Mar 2011 14:33:03 +1300
From: Jason Haar <Jason.Haar@...1299...>
MIME-Version: 1.0
References: <AANLkTi=gX2zHuk40P5RVtM8XmgZCp3V5_o20OeSy80N_@...278...>
In-Reply-To: <AANLkTi=gX2zHuk40P5RVtM8XmgZCp3V5_o20OeSy80N_@...278...>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 03/11/2011 02:04 PM, Vineet Kumar wrote:
> Hi,
>   Due to the reliability layer wrapping the SSL handshake packets plus
> a few non-SSL messages during tunnel-setup time the openvpn protocol
> when targeted to port 443 (instead of 1194) ends up breaking if a
> proxy sits in the middle and is expecting SSL procol on 443. How can I
> get around this (well apart of not using 443)?

Are you talking about transparent https proxies? Such devices are
designed to block non-SSL applications (which openvpn is), and can even
block HTTPS transactions that don't use "sanctioned" CAs

I think you'll be out of luck making openvpn run through such an environment

> Also, doesn't this make openvpn different from other SSL VPNs which
> advertise the fact that they are truly SSL?
>

Yes it does

-- 
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +64 3 9635 377 Fax: +64 3 9635 417
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


