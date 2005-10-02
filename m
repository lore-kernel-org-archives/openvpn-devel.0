From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Patch: Admin interface shows server IP when
 connected
In-Reply-To: <43404D99.8080309@...361...>
Message-ID: <Pine.LNX.4.58.0510021718300.8243@...41...>
References: <43404D99.8080309@...361...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Oct  2 19:39:04 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Rolf Fokkens <r.fokkens@...361...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

On Sun, 2 Oct 2005, Rolf Fokkens wrote:

> Hi,
> 
> I created an OpenVPN admin interface, which I want to show the actual 
> connected server of a client. The normal "state" command in the admin 
> interface does not provide the information. The attached patch adds an 
> extra argument to the "state" result which shows the server's IP. Like this:
> 
>     [root@...464... ~]# echo state | nc 0.0.0.0 5000
>      >INFO:OpenVPN Management Interface Version 1 -- type 'help' for
>     more info
>     1128286300,CONNECTED,SUCCESS,,145.66.1.1
>     END
>     [root@...464... ~]#
> 
> James Yonan once told me that this actualy changes the admin API, so it 
> may break some admin interfaces. For those however who can use it I 
> attached the patch.
> 
> Rolf

Rolf,

Thanks for the patch -- I see this as being a 2.1 thing, mostly so as not 
to change the the management API mid-stream in 2.0.x.

What I would like to do is collect all of the managment interface changes 
which affect the API and release them simultaneously as "Management 
Interface Version 2".

James

