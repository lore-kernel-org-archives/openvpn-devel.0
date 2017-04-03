References: <323226c5-b097-9d1c-5d43-0790cfa1ccfb@...277...>
	<1b07213d-4844-d629-195e-3211735b854c@...277...>
	<20170403201504.GA93896@...1296...>
From: debbie10t <debbie10t@...277...>
Message-ID: <9cdcac22-40bb-0ebf-c21f-a8b96f55a5d2@...277...>
Date: Mon, 3 Apr 2017 21:37:48 +0100
MIME-Version: 1.0
In-Reply-To: <20170403201504.GA93896@...1296...>
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>




On 03/04/17 21:15, Gert Doering wrote:
> Hi,
>
> On Mon, Apr 03, 2017 at 08:51:23PM +0100, debbie10t wrote:
>> Turns out to be:
>> freenode#gentoo <stqn> you need to disable the bindist use flag
>> (preferably globally) to get EC support
>
> "why"?

Something to do with Licences:
#gentoo
<me> out of curiosity .. i presume gentoo intend to include elliptic 
curve algos in openssl at some time ?
<iamben> they are included if you disable the bindist flag
<iamben> USE=bindist disables them, so that you can legally redistribute 
your package as built

<iamben> those algorithms are (possibly) patent-encumbered



> (But thanks for figuring out and documenting)

No prob :)


