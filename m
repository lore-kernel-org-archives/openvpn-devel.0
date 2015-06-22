Message-ID: <55887C2D.6080203@...1490...>
Date: Tue, 23 Jun 2015 09:20:45 +1200
From: Jason Haar <Jason_Haar@...1490...>
MIME-Version: 1.0
References: <55882EBE.9030503@...1147...>
In-Reply-To: <55882EBE.9030503@...1147...>
Subject: Re: [Openvpn-devel] about client-cert-not-required
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 23/06/15 03:50, Jan Just Keijser wrote:
> 1) do we think it's valuable to add something like this (currently NO 
> cert checks are done when 'client-cert-not-required' is used) ?

sounds like what you really want is for this to be renamed
"--verify-client-cert (none|optional|required)" - with the
default still being "required" of course - sort of like Apache's
SSLVerifyClient

-- 
Cheers

Jason Haar
Corporate Information Security Manager, Trimble Navigation Ltd.
Phone: +1 408 481 8171
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


