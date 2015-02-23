Message-ID: <54EB5549.9050108@...1114...>
Date: Mon, 23 Feb 2015 17:28:57 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20140827093409.GA659@...1900...> <20150223155132.GA28440@...2018...>
	<20150223161832.GN8134@...1296...>
In-Reply-To: <20150223161832.GN8134@...1296...>
Subject: Re: [Openvpn-devel] Add support for Keying Material Exporter [RFC
 5705]
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Daniel Kubec <niel@...1898...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 23/02/15 17:18, Gert Doering wrote:
> Hi,
> 
> On Mon, Feb 23, 2015 at 04:51:34PM +0100, Daniel Kubec wrote:
>> Keying Material Exporter [RFC 5705] Patch rebased to actual master
>> branch.
> 
> There definitely needs to be much(!) more documentation about this, maybe 
> an extra .txt file under doc/ - I still(!) have *no* idea what this is 
> useful for, or how to use it, so right now this is "extra code complexity
> with no well-explained gain" to me.
> 
> I understand that David understands this, but we really really need to 
> have documentation understandable to non-crypto-geeks about it before it 
> can go in.

Fair enough.

Daniel, would it be possible to add some docs and possibly a very simple
tool + plugin which could be used to demonstrate this feature?  API docs
should go into the docs/ sub-folder and the demo code into
sample/sample-plugins/.

I suggest this comes as a separate patch, for patch maintainability.
Will probably be a good idea to even split docs and demo/sample code
into separate patches too?   (I'm not too keen on big patches doing
several things)


- -- 
kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlTrVUYACgkQDC186MBRfrr0jQCgjOBRc8VHLcuh9soopp5Ww+kd
3yMAnitmckErbeDYcwa44ZPFKOpdXbwq
=u30V
-----END PGP SIGNATURE-----

