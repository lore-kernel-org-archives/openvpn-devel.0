Message-ID: <54FA0392.3030401@...1114...>
Date: Fri, 06 Mar 2015 20:44:18 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20140827093409.GA659@...1900...>
	<20150223155132.GA28440@...2018...>	<20150223161832.GN8134@...1296...>	<54EB5549.9050108@...1114...>
	<54EE4F19.1000108@...1856...>
	<CAEW7GUvzbvR1FFSVA86pcY7tM4owucU88xTpLrUybDDCErpnTQ@...278...>
In-Reply-To: <CAEW7GUvzbvR1FFSVA86pcY7tM4owucU88xTpLrUybDDCErpnTQ@...278...>
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
To: daniel kubec <niel@...1898...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/03/15 01:03, daniel kubec wrote:
> Greetings Steffan, David and Gert
> 
> Thank you very much for your comments.
> 
> 1) log level switched to D_TLS_DEBUG_MED 2) ekm_size removed,
> ekm_size != 0 condition is used instead. 3) changed to:
> exported_keying_material 4) minimum set to 16 bytes and maximum set
> to 4095 bytes.
> 
> Added 2 patches related to [RFC-5705] (code + docs).
> 
> Regards
> 
> Daniel
> 
> On 25 February 2015 at 23:39, Steffan Karger <steffan@...1856...>
> wrote: On 23-02-15 17:28, David Sommerseth wrote:
>>>> On 23/02/15 17:18, Gert Doering wrote:
>>>>> On Mon, Feb 23, 2015 at 04:51:34PM +0100, Daniel Kubec
>>>>> wrote:
>>>>>> Keying Material Exporter [RFC 5705] Patch rebased to
>>>>>> actual master branch.
>>>> 
>>>>> There definitely needs to be much(!) more documentation
>>>>> about this, maybe an extra .txt file under doc/ - I
>>>>> still(!) have *no* idea what this is useful for, or how to
>>>>> use it, so right now this is "extra code complexity with no
>>>>> well-explained gain" to me.
>>>> 
>>>>> I understand that David understands this, but we really
>>>>> really need to have documentation understandable to
>>>>> non-crypto-geeks about it before it can go in.
>>>> 
>>>> Fair enough.
>>>> 
>>>> Daniel, would it be possible to add some docs and possibly a
>>>> very simple tool + plugin which could be used to demonstrate
>>>> this feature?  API docs should go into the docs/ sub-folder
>>>> and the demo code into sample/sample-plugins/.
>>>> 
>>>> I suggest this comes as a separate patch, for patch 
>>>> maintainability. Will probably be a good idea to even split
>>>> docs and demo/sample code into separate patches too?   (I'm
>>>> not too keen on big patches doing several things)
> 
> Agreed that a bit more documentation would make this patch a lot
> more useful.
> 
> - From a crypto perspective I think the codes is good. I do have a
> few practicals nits though:
> 
> 1) Instead of using just M_DEBUG in dmsg(), please add a log
> level. Since you are printing derived key material, I think a
> rather high log level like D_TLS_DEBUG, or perhaps D_TLS_DEBUG_MED
> would make sense.
> 
> 2) ekm_used in struct tls_options is equivalent to (ekm_size > 0).
> You could just get rid of this extra variable.
> 
> 3) tls_binding_key might not be the best env var name. That name
> hints at the use case you have in mind for this mechanisms, but it
> does not cover all use cases, nor does it easily match to the 
> 'keying-material-exporter' name of the option you introduce.
> Something like 'exported_keying_material' might me more
> appropriate.
> 
> 4) We might want to enforce a minimum length for the exported
> keying material. How about 128 bits / 16 bytes? Just to prevent a
> user making a typo from ending up with ridiculously small keys.
> 
> -Steffan

I have looked at the plug-in side of the code, and code wise it looks
good to me.  But I wonder if there's an unintended bug here, related
to the usage of format_hex_ex().

I have written a very simple plug-in, basically based on
sample/sample-plugins/log/log_v3.c.  It attaches itself to
OPENVPN_PLUGIN_TLS_FINAL, and when this stage happens, it logs the
contents of the 'exported_keying_material' environment variable when
reaching this state.

The log code looks like this:
- ---------------------------------------------------------------------
    const char *keyingmat = NULL;

    keyingmat = get_env("exported_keying_material", args->envp);
    ovpnlog(PLOG_NOTE, "rfc5705-tester",
            "*** Received keying material %s", keyingmat);
- ---------------------------------------------------------------------

This all seems to work fine, until I pass a 'len' argument larger than
19, then I see this in my log:

  Received keying material 642e0422ed1ea8ed8d93b471bfd258[more...]

If I reduce it to 19, the '[more...]' part disappears.  Increasing the
lenght of the "EXPORTER" string doesn't seem to help either.  As the
length is restricted to 4096, I'd expect to go at least a bit further
than 20.

I wonder if it is just a misunderstanding how of format_hex_ex()
works, where the maxoutput is not a traditional truncation limit.  If
maxoutput is 0, it will allocate the needed space for the string
buffer automatically, based on the input string.  The "traditional"
truncation limit is set by the 'size' argument.


- -- 
kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlT6A4wACgkQDC186MBRfrqsXwCeOY9CC0/UIlUNErcytTcniyVN
rwoAn2TcaaoILYjCN2C6mFb59jmqa4Bf
=fdfs
-----END PGP SIGNATURE-----

