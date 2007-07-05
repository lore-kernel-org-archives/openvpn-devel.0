From: "Dave" <dev@...575...>
Date: Thu, 5 Jul 2007 10:27:21 -0500
Message-ID: <001501c7bf18$fb69e550$16ada8c0@...576...>
MIME-Version: 1.0
In-Reply-To: <BAY143-F326503F7C210AFBD41ECEDF7020@...512...>
Subject: Re: [Openvpn-devel] Building new TAP driver (tap0901) on windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Girish KS' <girish.ks@...160...>, openvpn-devel@lists.sourceforge.net

> Hi,
> 
>    Can anybody tell me the procedure of building tap driver 
> on windows? I'm 
> able to build tap0801 using WINDDK 3790, but tap0901 build is 
> failing. It 
> says autodefs/defs.h file is missing? The folder autodefs is 
> not in the 
> current directory. What should i do to get the defs.h header file?
...

That's not a DDK problem, but rather that file is generated when initially
configuring the code for make.  I can't remember just where, but I think
when you run the configure.ac.  The autodefs directory will be created, and
the defs.h will be in it (along with some other stuff).

-Dave


