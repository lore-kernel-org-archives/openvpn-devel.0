From: debbie10t <debbie10t@...277...>
References: <323226c5-b097-9d1c-5d43-0790cfa1ccfb@...277...>
Message-ID: <1b07213d-4844-d629-195e-3211735b854c@...277...>
Date: Mon, 3 Apr 2017 20:51:23 +0100
MIME-Version: 1.0
In-Reply-To: <323226c5-b097-9d1c-5d43-0790cfa1ccfb@...277...>
Subject: Re: [Openvpn-devel] gentoo build inconsistency with openssl in
 openvpn using elliptic curve cert
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



On 02/04/17 00:57, debbie10t wrote:
> Hi,
>
> sorry, I know this is slightly off-topic ..
> I understand this may be down to a gentoo maintainer
> but as I don't know I decided to document the problem.
>
> Thanks for your help
>
>
>
>
> The problem:
>
> On gentoo when building openvpn there is a difference depending on how
> openvpn is built:
>
> The first method generates openvpn which cannot use EC PKI
> The second method generates openvpn which can use EC PKI
>

Turns out to be:
freenode#gentoo <stqn> you need to disable the bindist use flag 
(preferably globally) to get EC support

then re-build openssl then openvpn

Problem solved.


