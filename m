Message-ID: <54EE4F19.1000108@...1856...>
Date: Wed, 25 Feb 2015 23:39:21 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <20140827093409.GA659@...1900...>
	<20150223155132.GA28440@...2018...>	<20150223161832.GN8134@...1296...>
	<54EB5549.9050108@...1114...>
In-Reply-To: <54EB5549.9050108@...1114...>
Subject: Re: [Openvpn-devel] Add support for Keying Material Exporter [RFC
 5705]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 23-02-15 17:28, David Sommerseth wrote:
> On 23/02/15 17:18, Gert Doering wrote:
>> On Mon, Feb 23, 2015 at 04:51:34PM +0100, Daniel Kubec wrote:
>>> Keying Material Exporter [RFC 5705] Patch rebased to actual
>>> master branch.
> 
>> There definitely needs to be much(!) more documentation about
>> this, maybe an extra .txt file under doc/ - I still(!) have *no*
>> idea what this is useful for, or how to use it, so right now this
>> is "extra code complexity with no well-explained gain" to me.
> 
>> I understand that David understands this, but we really really
>> need to have documentation understandable to non-crypto-geeks
>> about it before it can go in.
> 
> Fair enough.
> 
> Daniel, would it be possible to add some docs and possibly a very
> simple tool + plugin which could be used to demonstrate this
> feature?  API docs should go into the docs/ sub-folder and the demo
> code into sample/sample-plugins/.
> 
> I suggest this comes as a separate patch, for patch
> maintainability. Will probably be a good idea to even split docs
> and demo/sample code into separate patches too?   (I'm not too keen
> on big patches doing several things)

Agreed that a bit more documentation would make this patch a lot more
useful.

- From a crypto perspective I think the codes is good. I do have a few
practicals nits though:

1) Instead of using just M_DEBUG in dmsg(), please add a log level.
Since you are printing derived key material, I think a rather high log
level like D_TLS_DEBUG, or perhaps D_TLS_DEBUG_MED would make sense.

2) ekm_used in struct tls_options is equivalent to (ekm_size > 0). You
could just get rid of this extra variable.

3) tls_binding_key might not be the best env var name. That name hints
at the use case you have in mind for this mechanisms, but it does not
cover all use cases, nor does it easily match to the
'keying-material-exporter' name of the option you introduce. Something
like 'exported_keying_material' might me more appropriate.

4) We might want to enforce a minimum length for the exported keying
material. How about 128 bits / 16 bytes? Just to prevent a user making
a typo from ending up with ridiculously small keys.

- -Steffan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJU7k8PAAoJEJgCyj0AftKIWBUIAJPG7+nbNS9dRbwDzOA8NpBU
d0ueiNskJ5gGTfeUoRZwPK/wSlxPtRP0j1wKg7ltwJOvgJM7MCewI2KNxobPE/BF
PptAzH8PU2X8YHMRhbgfcER4CyvTlg/KUW5PEieL7c1zAjq5pkQJMqTNIToq51Wo
bUmQOEdtPuY5J3PF/06NpnKr9ZigM2FiIpx+M+GOietav8MX7a4OrGQVPnaZQo6E
rtwCfhVTAxeaitRsWiJjuvg5tJOCqbs7uC8imjNNM6kCZzSpfJkC1nDDP6g+JAOa
mTKgrbKS1HWYDlsE8kaSg8LLADWFix8Q2lTtGeXGUlbITtHYEE2n3DEAXqtgr4I=
=vOYB
-----END PGP SIGNATURE-----

