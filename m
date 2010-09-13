Message-ID: <4C8E9E7B.9020308@...1299...>
Date: Tue, 14 Sep 2010 09:58:19 +1200
From: Jason Haar <Jason.Haar@...1299...>
MIME-Version: 1.0
References: <54C854C313159D429F344FB1DE1A6526110D96A5@...1403...>
In-Reply-To: <54C854C313159D429F344FB1DE1A6526110D96A5@...1403...>
Subject: Re: [Openvpn-devel] Enhancements.
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

 On 09/14/2010 08:52 AM, Brad Dameron wrote:
>
>
> Also can there be reporting added for the server side to show what
> version the client is connecting with?
>
>  
>
I agree. I have previously asked for client version and OS to be
"pushed" during the initial phase so that the server can be decisions
based on it. Currently we have some NAC checks built into the initial
connection phase (thanks to openvpn's great scripting options) and we
have to use portscans to differentiate between Windows and Unix. I'd
rather the client just told me so that we could be finer grained in our
reactions without resorting to such methods.

-- 
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +64 3 9635 377 Fax: +64 3 9635 417
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


