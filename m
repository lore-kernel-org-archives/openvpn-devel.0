Message-ID: <5da65ebd0705020505r145fb9e6r6a5795741eb18eb1@...278...>
Date: Wed, 2 May 2007 07:05:43 -0500
From: "Chris Tjon" <chris.tjon@...277...>
In-Reply-To: <200705021354.11456.noamr@...117...>
MIME-Version: 1.0
References: <200705021354.11456.noamr@...117...>
Subject: Re: [Openvpn-devel] OpenVPN server in a mixed (windows unix)
	enviroment
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Noam Rathaus <noamr@...117...>
Cc: openvpn-devel@lists.sourceforge.net

My experience is that it is not possible due to the path's involved in
identifying your certs... obviously, in Windows, they are
C:\flajldkja\jlkdjfla\ etc while in Linux(or Unix) they are
/blah/blah/....

Other than that, my files are identical.

Chris



On 5/2/07, Noam Rathaus <noamr@...117...> wrote:
> Hi,
>
> I am having difficulties getting both my UNIX VPN clients and my Windows VPN
> clients to use the same server.conf file, is this even possible or do I need
> two separate VPN servers one using TAP while the other uses TUN?
>
> --
>  Noam Rathaus
>  CTO
>  1616 Anderson Rd.
>  McLean, VA 22102
>  Tel: 703.286.7725 extension 105
>  Fax: 888.667.7740
>  noamr@...117...
>  http://www.beyondsecurity.com
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

