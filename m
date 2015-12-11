Message-ID: <C74F1CC282A64BBAB8F17F430B43CA35@...2089...>
From: <debbie10t@...277...>
References: <AF48117BC12D429393E4D93EFBA7E72E@...2089...>
	<20151211193817.GT24952@...1296...>
	<BAEB59A88E964992802EAD23559AB9E4@...2089...>
	<20151211200834.GV24952@...1296...>
Date: Fri, 11 Dec 2015 20:23:38 -0000
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Opttion "client-nat" not recognised
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net


----- Original Message ----- 
From: "Gert Doering" <gert@...1296...>
To: <debbie10t@...277...>
Cc: "Gert Doering" <gert@...1296...>; 
<openvpn-devel@lists.sourceforge.net>
Sent: Friday, December 11, 2015 8:08 PM
Subject: Re: [Openvpn-devel] Opttion "client-nat" not recognised

> the code says "four arguments
> have to be there" and the git master code says "four arguments have
> to be there, and if a fifth is given, it is a syntax error".
>
> So just leave off the last argument - it was silently ignored all along.

Very well, I have dropped the second mask argument and the push is
at least accepted now.  Checking logs at --verb 6 for details ..
Thanks.




