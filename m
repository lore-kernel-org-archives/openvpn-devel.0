From: Denis Vlasenko <vda@...216...>
Subject: Re: [Openvpn-devel] Re: [PATCH - 1 of 4]  Set source address for UDP packets from multihomed server
References: <twig.1090916738.94261@...41...>
In-Reply-To: <twig.1090916738.94261@...41...>
MIME-Version: 1.0
Message-Id: <200407271505.34458.vda@...216...>
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
Date: Tue Jul 27 05:07:09 2004
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
To: James Yonan <jim@...41...>, Neil Brown <neilb@...253...>
Cc: openvpn-devel@lists.sourceforge.net

On Tuesday 27 July 2004 11:25, James Yonan wrote:
> Neil,
>
> Thanks for the patches... here are some comments:
>
> * You've obviously put a lot of effort into understanding the code to wri=
te
> this patch.  But did you consider any alternative approaches, such as
> starting multiple OpenVPN instances and binding each to a separate local
> interface?

This will fail for dynamic ip addresses and dynamic interfaces.
Also it will incur memory and context switch time penalties.
Just imagine a host with 100 ip addresses.
--
vda


