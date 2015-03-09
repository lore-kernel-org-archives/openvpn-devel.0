MIME-Version: 1.0
Sender: kubec.daniel@...277...
In-Reply-To: <54FA0392.3030401@...1114...>
References: <20140827093409.GA659@...1900...> <20150223155132.GA28440@...2018...>
	<20150223161832.GN8134@...1296...>
	<54EB5549.9050108@...1114...> <54EE4F19.1000108@...1856...>
	<CAEW7GUvzbvR1FFSVA86pcY7tM4owucU88xTpLrUybDDCErpnTQ@...278...>
	<54FA0392.3030401@...1114...>
Date: Mon, 9 Mar 2015 19:11:05 +0100
Message-ID: <CAEW7GUu5HOs2b-Edkt8SJ0PbwtK3qTZ17opdn_y1r7PauyV-UA@...278...>
From: daniel kubec <niel@...1898...>
Content-Type: multipart/mixed; boundary=001a11c2d2ea28bdfa0510def5a3
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
To: openvpn-devel@lists.sourceforge.net

--001a11c2d2ea28bdfa0510def5a3
Content-Type: text/plain; charset=UTF-8

Hi Steffan, David and Gert,

I fixed bug related to format_hex_ex() for size > 20, removed bracers
arround  "-keying-material-exporter label len" and added upper bound
to the check in options.c.

king regards

Daniel

On 6 March 2015 at 20:44, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 02/03/15 01:03, daniel kubec wrote:
>> Greetings Steffan, David and Gert
>>
>> Thank you very much for your comments.
>>
>> 1) log level switched to D_TLS_DEBUG_MED 2) ekm_size removed,
>> ekm_size != 0 condition is used instead. 3) changed to:
>> exported_keying_material 4) minimum set to 16 bytes and maximum set
>> to 4095 bytes.
>>
>> Added 2 patches related to [RFC-5705] (code + docs).
>>
>> Regards
>>
>> Daniel
>>
>> On 25 February 2015 at 23:39, Steffan Karger <steffan@...1856...>
>> wrote: On 23-02-15 17:28, David Sommerseth wrote:
>>>>> On 23/02/15 17:18, Gert Doering wrote:
>>>>>> On Mon, Feb 23, 2015 at 04:51:34PM +0100, Daniel Kubec
>>>>>> wrote:
>>>>>>> Keying Material Exporter [RFC 5705] Patch rebased to
>>>>>>> actual master branch.
>>>>>
>>>>>> There definitely needs to be much(!) more documentation
>>>>>> about this, maybe an extra .txt file under doc/ - I
>>>>>> still(!) have *no* idea what this is useful for, or how to
>>>>>> use it, so right now this is "extra code complexity with no
>>>>>> well-explained gain" to me.
>>>>>
>>>>>> I understand that David understands this, but we really
>>>>>> really need to have documentation understandable to
>>>>>> non-crypto-geeks about it before it can go in.
>>>>>
>>>>> Fair enough.
>>>>>
>>>>> Daniel, would it be possible to add some docs and possibly a
>>>>> very simple tool + plugin which could be used to demonstrate
>>>>> this feature?  API docs should go into the docs/ sub-folder
>>>>> and the demo code into sample/sample-plugins/.
>>>>>
>>>>> I suggest this comes as a separate patch, for patch
>>>>> maintainability. Will probably be a good idea to even split
>>>>> docs and demo/sample code into separate patches too?   (I'm
>>>>> not too keen on big patches doing several things)
>>
>> Agreed that a bit more documentation would make this patch a lot
>> more useful.
>>
>> - From a crypto perspective I think the codes is good. I do have a
>> few practicals nits though:
>>
>> 1) Instead of using just M_DEBUG in dmsg(), please add a log
>> level. Since you are printing derived key material, I think a
>> rather high log level like D_TLS_DEBUG, or perhaps D_TLS_DEBUG_MED
>> would make sense.
>>
>> 2) ekm_used in struct tls_options is equivalent to (ekm_size > 0).
>> You could just get rid of this extra variable.
>>
>> 3) tls_binding_key might not be the best env var name. That name
>> hints at the use case you have in mind for this mechanisms, but it
>> does not cover all use cases, nor does it easily match to the
>> 'keying-material-exporter' name of the option you introduce.
>> Something like 'exported_keying_material' might me more
>> appropriate.
>>
>> 4) We might want to enforce a minimum length for the exported
>> keying material. How about 128 bits / 16 bytes? Just to prevent a
>> user making a typo from ending up with ridiculously small keys.
>>
>> -Steffan
>
> I have looked at the plug-in side of the code, and code wise it looks
> good to me.  But I wonder if there's an unintended bug here, related
> to the usage of format_hex_ex().
>
> I have written a very simple plug-in, basically based on
> sample/sample-plugins/log/log_v3.c.  It attaches itself to
> OPENVPN_PLUGIN_TLS_FINAL, and when this stage happens, it logs the
> contents of the 'exported_keying_material' environment variable when
> reaching this state.
>
> The log code looks like this:
> - ---------------------------------------------------------------------
>     const char *keyingmat = NULL;
>
>     keyingmat = get_env("exported_keying_material", args->envp);
>     ovpnlog(PLOG_NOTE, "rfc5705-tester",
>             "*** Received keying material %s", keyingmat);
> - ---------------------------------------------------------------------
>
> This all seems to work fine, until I pass a 'len' argument larger than
> 19, then I see this in my log:
>
>   Received keying material 642e0422ed1ea8ed8d93b471bfd258[more...]
>
> If I reduce it to 19, the '[more...]' part disappears.  Increasing the
> lenght of the "EXPORTER" string doesn't seem to help either.  As the
> length is restricted to 4096, I'd expect to go at least a bit further
> than 20.
>
> I wonder if it is just a misunderstanding how of format_hex_ex()
> works, where the maxoutput is not a traditional truncation limit.  If
> maxoutput is 0, it will allocate the needed space for the string
> buffer automatically, based on the input string.  The "traditional"
> truncation limit is set by the 'size' argument.
>
>
> - --
> kind regards,
>
> David Sommerseth
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1
>
> iEYEARECAAYFAlT6A4wACgkQDC186MBRfrqsXwCeOY9CC0/UIlUNErcytTcniyVN
> rwoAn2TcaaoILYjCN2C6mFb59jmqa4Bf
> =fdfs
> -----END PGP SIGNATURE-----

--001a11c2d2ea28bdfa0510def5a3
Content-Type: application/octet-stream; name="openvpn-rfc5705-v2.patch"
Content-Disposition: attachment; filename="openvpn-rfc5705-v2.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i726phia0

RnJvbSBkYzg4ZTYyZGY5OWQ3NzJiN2Q0NDJhODJmMGJhOWQ4YTRkNTNmMzk4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgS3ViZWMgPG5pZWxAcnRmbS5jej4KRGF0ZTogTW9u
LCA5IE1hciAyMDE1IDE4OjU4OjI1ICswMTAwClN1YmplY3Q6IFtQQVRDSCAxLzFdIEFkZGVkIHN1
cHBvcnQgZm9yIFRMUyBLZXlpbmcgTWF0ZXJpYWwgRXhwb3J0ZXJzIFtSRkMtNTcwNV0KCktleWlu
ZyBNYXRlcmlhbCBFeHBvcnRlciBbUkZDLTU3MDVdIGFsbG93IGFkZGl0aW9uYWwga2V5aW5nIG1h
dGVyaWFsIHRvIGJlCmRlcml2ZWQgZnJvbSBleGlzdGluZyBUTFMgY2hhbm5lbC4gVGhpcyBleHBv
cnRlZCBrZXlpbmcgbWF0ZXJpYWwgY2FuIHRoZW4gYmUKdXNlZCBmb3IgYSB2YXJpZXR5IG9mIHB1
cnBvc2VzLgotLS0KIGRvYy9vcGVudnBuLjggICAgICAgICAgICAgIHwgICAxMSArKysrKysrKysr
Kwogc3JjL29wZW52cG4vaW5pdC5jICAgICAgICAgfCAgIDE2ICsrKysrKysrKysrKysrKysKIHNy
Yy9vcGVudnBuL29wdGlvbnMuYyAgICAgIHwgICAyNyArKysrKysrKysrKysrKysrKysrKysrKysr
KysKIHNyYy9vcGVudnBuL29wdGlvbnMuaCAgICAgIHwgICAgNiArKysrKysKIHNyYy9vcGVudnBu
L3NzbC5jICAgICAgICAgIHwgICAgNCArKysrCiBzcmMvb3BlbnZwbi9zc2xfYmFja2VuZC5oICB8
ICAgMTMgKysrKysrKysrKysrKwogc3JjL29wZW52cG4vc3NsX2NvbW1vbi5oICAgfCAgICA1ICsr
KysrCiBzcmMvb3BlbnZwbi9zc2xfb3BlbnNzbC5jICB8ICAgMzIgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysKIHNyYy9vcGVudnBuL3NzbF9wb2xhcnNzbC5jIHwgICAgNiArKysrKysK
IDkgZmlsZXMgY2hhbmdlZCwgMTIwIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZG9jL29wZW52cG4uOCBiL2RvYy9vcGVudnBuLjgKaW5kZXggOTU1MTU2Ni4uNzRj
ODg2YiAxMDA2NDQKLS0tIGEvZG9jL29wZW52cG4uOAorKysgYi9kb2Mvb3BlbnZwbi44CkBAIC0y
Njg1LDYgKzI2ODUsMTcgQEAgY2xpZW50LWNvbm5lY3QpLCB0aGVuCiBldmVyeSBtb2R1bGUgYW5k
IHNjcmlwdCBtdXN0IHJldHVybiBzdWNjZXNzICgwKSBpbiBvcmRlciBmb3IKIHRoZSBjb25uZWN0
aW9uIHRvIGJlIGF1dGhlbnRpY2F0ZWQuCiAuXCIqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioKKy5UUAorLkIgXC1cLWtleWluZy1tYXRlcmlh
bC1leHBvcnRlciBsYWJlbCBsZW4KK1NhdmUgRXhwb3J0ZWQgS2V5aW5nIE1hdGVyaWFsIFtSRkM1
NzA1XSBvZiBsZW4gYnl0ZXMgKG1pbi4gMTYgYnl0ZXMpIHVzaW5nIAorbGFiZWwgaW4gZW52aXJv
bm1lbnQgKGV4cG9ydGVkX2tleWluZ19tYXRlcmlhbCkgZm9yIHVzZSBieSBwbHVnaW5zIGluIAor
T1BFTlZQTl9QTFVHSU5fVExTX0ZJTkFMIGNhbGxiYWNrLgorCitOb3RlIHRoYXQgZXhwb3J0ZXIg
bGFiZWxzIGhhdmUgdGhlIHBvdGVudGlhbCB0byBjb2xsaWRlIHdpdGggZXhpc3RpbmcgUFJGCits
YWJlbHMuIEluIG9yZGVyIHRvIHByZXZlbnQgdGhpcywgbGFiZWxzIE1VU1QgYmVnaW4gd2l0aCAi
RVhQT1JURVIiLgorCitUaGlzIG9wdGlvbiByZXF1aXJlcyBPcGVuU1NMIDEuMC4xIG9yIG5ld2Vy
LgorLlwiKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqCiAuU1MgU2VydmVyIE1vZGUKIFN0YXJ0aW5nIHdpdGggT3BlblZQTiAyLjAsIGEgbXVs
dGktY2xpZW50IFRDUC9VRFAgc2VydmVyIG1vZGUKIGlzIHN1cHBvcnRlZCwgYW5kIGNhbiBiZSBl
bmFibGVkIHdpdGggdGhlCmRpZmYgLS1naXQgYS9zcmMvb3BlbnZwbi9pbml0LmMgYi9zcmMvb3Bl
bnZwbi9pbml0LmMKaW5kZXggYjY3MGE0OC4uNzYzM2Y2MiAxMDA2NDQKLS0tIGEvc3JjL29wZW52
cG4vaW5pdC5jCisrKyBiL3NyYy9vcGVudnBuL2luaXQuYwpAQCAtMjI1OSw2ICsyMjU5LDIyIEBA
IGRvX2luaXRfY3J5cHRvX3RscyAoc3RydWN0IGNvbnRleHQgKmMsIGNvbnN0IHVuc2lnbmVkIGlu
dCBmbGFncykKICAgdG8uY29tcF9vcHRpb25zID0gb3B0aW9ucy0+Y29tcDsKICNlbmRpZgogCisj
aWYgZGVmaW5lZChFTkFCTEVfQ1JZUFRPX09QRU5TU0wpICYmIE9QRU5TU0xfVkVSU0lPTl9OVU1C
RVIgPj0gMHgxMDAwMTAwMAorICBpZiAob3B0aW9ucy0+a2V5aW5nX21hdGVyaWFsX2V4cG9ydGVy
X2xhYmVsKQorICAgIHsKKyAgICAgIHRvLmVrbV9zaXplID0gb3B0aW9ucy0+a2V5aW5nX21hdGVy
aWFsX2V4cG9ydGVyX2xlbmd0aDsKKyAgICAgIGlmICh0by5la21fc2l6ZSA8IDE2IHx8IHRvLmVr
bV9zaXplID4gNDA5NSkKKyAgICAgICAgICB0by5la21fc2l6ZSA9IDA7CisKKyAgICAgIHRvLmVr
bV9sYWJlbCA9IG9wdGlvbnMtPmtleWluZ19tYXRlcmlhbF9leHBvcnRlcl9sYWJlbDsKKyAgICAg
IHRvLmVrbV9sYWJlbF9zaXplID0gc3RybGVuKHRvLmVrbV9sYWJlbCk7CisgICAgfQorICBlbHNl
CisgICAgeworICAgICAgdG8uZWttX3NpemUgPSAwOworICAgIH0KKyNlbmRpZgorCiAgIC8qIFRM
UyBoYW5kc2hha2UgYXV0aGVudGljYXRpb24gKC0tdGxzLWF1dGgpICovCiAgIGlmIChvcHRpb25z
LT50bHNfYXV0aF9maWxlKQogICAgIHsKZGlmZiAtLWdpdCBhL3NyYy9vcGVudnBuL29wdGlvbnMu
YyBiL3NyYy9vcGVudnBuL29wdGlvbnMuYwppbmRleCBkZjlhNjQxLi45ODY2ZGQzIDEwMDY0NAot
LS0gYS9zcmMvb3BlbnZwbi9vcHRpb25zLmMKKysrIGIvc3JjL29wZW52cG4vb3B0aW9ucy5jCkBA
IC02MTMsNiArNjEzLDEwIEBAIHN0YXRpYyBjb25zdCBjaGFyIHVzYWdlX21lc3NhZ2VbXSA9CiAg
ICItLXg1MDktdHJhY2sgeCAgOiBTYXZlIHBlZXIgWDUwOSBhdHRyaWJ1dGUgeCBpbiBlbnZpcm9u
bWVudCBmb3IgdXNlIGJ5XG4iCiAgICIgICAgICAgICAgICAgICAgICBwbHVnaW5zIGFuZCBtYW5h
Z2VtZW50IGludGVyZmFjZS5cbiIKICNlbmRpZgorI2lmIGRlZmluZWQoRU5BQkxFX0NSWVBUT19P
UEVOU1NMKSAmJiBPUEVOU1NMX1ZFUlNJT05fTlVNQkVSID49IDB4MTAwMDEwMDAKKyAgIi0ta2V5
aW5nLW1hdGVyaWFsLWV4cG9ydGVyIGxhYmVsIGxlbiA6IFNhdmUgRXhwb3J0ZWQgS2V5aW5nIE1h
dGVyaWFsIChSRkM1NzA1KVxuIgorICAiICAgICAgICAgICAgICAgICAgb2YgbGVuIGJ5dGVzICht
aW4uIDE2IGJ5dGVzKSB1c2luZyBsYWJlbCBpbiBlbnZpcm9ubWVudCBmb3IgdXNlIGJ5IHBsdWdp
bnMuXG4iCisjZW5kaWYKICAgIi0tcmVtb3RlLWNlcnQta3UgdiAuLi4gOiBSZXF1aXJlIHRoYXQg
dGhlIHBlZXIgY2VydGlmaWNhdGUgd2FzIHNpZ25lZCB3aXRoXG4iCiAgICIgICAgICAgICAgICAg
ICAgICBleHBsaWNpdCBrZXkgdXNhZ2UsIHlvdSBjYW4gc3BlY2lmeSBtb3JlIHRoYW4gb25lIHZh
bHVlLlxuIgogICAiICAgICAgICAgICAgICAgICAgdmFsdWUgc2hvdWxkIGJlIGdpdmVuIGluIGhl
eCBmb3JtYXQuXG4iCkBAIC03MDIzLDYgKzcwMjcsMjkgQEAgYWRkX29wdGlvbiAoc3RydWN0IG9w
dGlvbnMgKm9wdGlvbnMsCiAgICAgICBvcHRpb25zLT51c2VfcGVlcl9pZCA9IHRydWU7CiAgICAg
ICBvcHRpb25zLT5wZWVyX2lkID0gYXRvaShwWzFdKTsKICAgICB9CisjaWYgZGVmaW5lZChFTkFC
TEVfQ1JZUFRPX09QRU5TU0wpICYmIE9QRU5TU0xfVkVSU0lPTl9OVU1CRVIgPj0gMHgxMDAwMTAw
MAorICBlbHNlIGlmIChzdHJlcSAocFswXSwgImtleWluZy1tYXRlcmlhbC1leHBvcnRlciIpICYm
IHBbMV0gJiYgcFsyXSkKKyAgICB7CisgICAgICBpbnQgZWttX2xlbmd0aCA9IHBvc2l0aXZlX2F0
b2kgKHBbMl0pOworCisgICAgICBWRVJJRllfUEVSTUlTU0lPTiAoT1BUX1BfR0VORVJBTCk7CisK
KyAgICAgIGlmIChzdHJuY21wKHBbMV0sICJFWFBPUlRFUiIsIDgpKQorICAgICAgICB7CisgICAg
ICAgICAgbXNnIChtc2dsZXZlbCwgIktleWluZyBtYXRlcmlhbCBleHBvcnRlciBsYWJlbCBtdXN0
IGJlZ2luIHdpdGggIgorICAgICAgICAgICAgICAgICAgICAgICAgICJcIkVYUE9SVEVSXCIiKTsK
KyAgICAgICAgICBnb3RvIGVycjsKKyAgICAgICAgfQorICAgICAgaWYgKGVrbV9sZW5ndGggPCAx
NiB8fCBla21fbGVuZ3RoID4gNDA5NSkKKyAgICAgICAgeworICAgICAgICAgIG1zZyAobXNnbGV2
ZWwsICJJbnZhbGlkIGtleWluZyBtYXRlcmlhbCBleHBvcnRlciBsZW5ndGgiKTsKKyAgICAgICAg
ICBnb3RvIGVycjsKKyAgICAgICAgfQorCisgICAgICBvcHRpb25zLT5rZXlpbmdfbWF0ZXJpYWxf
ZXhwb3J0ZXJfbGFiZWwgPSBwWzFdOworICAgICAgb3B0aW9ucy0+a2V5aW5nX21hdGVyaWFsX2V4
cG9ydGVyX2xlbmd0aCA9IGVrbV9sZW5ndGg7CisgICAgfQorI2VuZGlmCiAgIGVsc2UKICAgICB7
CiAgICAgICBpbnQgaTsKZGlmZiAtLWdpdCBhL3NyYy9vcGVudnBuL29wdGlvbnMuaCBiL3NyYy9v
cGVudnBuL29wdGlvbnMuaAppbmRleCA3YThiMjFlLi4xMDY4ZmUzIDEwMDY0NAotLS0gYS9zcmMv
b3BlbnZwbi9vcHRpb25zLmgKKysrIGIvc3JjL29wZW52cG4vb3B0aW9ucy5oCkBAIC01OTcsNiAr
NTk3LDEyIEBAIHN0cnVjdCBvcHRpb25zCiAKICAgYm9vbCB1c2VfcGVlcl9pZDsKICAgdWludDMy
X3QgcGVlcl9pZDsKKworI2lmIGRlZmluZWQoRU5BQkxFX0NSWVBUT19PUEVOU1NMKSAmJiBPUEVO
U1NMX1ZFUlNJT05fTlVNQkVSID49IDB4MTAwMDEwMDAKKyAgLyogS2V5aW5nIE1hdGVyaWFsIEV4
cG9ydGVycyBbUkZDIDU3MDVdICovCisgIGNvbnN0IGNoYXIgKmtleWluZ19tYXRlcmlhbF9leHBv
cnRlcl9sYWJlbDsKKyAgaW50IGtleWluZ19tYXRlcmlhbF9leHBvcnRlcl9sZW5ndGg7CisjZW5k
aWYKIH07CiAKICNkZWZpbmUgc3RyZXEoeCwgeSkgKCFzdHJjbXAoKHgpLCAoeSkpKQpkaWZmIC0t
Z2l0IGEvc3JjL29wZW52cG4vc3NsLmMgYi9zcmMvb3BlbnZwbi9zc2wuYwppbmRleCAyMjJjODI4
Li41NDliZmU2IDEwMDY0NAotLS0gYS9zcmMvb3BlbnZwbi9zc2wuYworKysgYi9zcmMvb3BlbnZw
bi9zc2wuYwpAQCAtMjE0Niw4ICsyMTQ2LDEyIEBAIGtleV9tZXRob2RfMl9yZWFkIChzdHJ1Y3Qg
YnVmZmVyICpidWYsIHN0cnVjdCB0bHNfbXVsdGkgKm11bHRpLCBzdHJ1Y3QgdGxzX3Nlc3NpCiAg
ICAqLwogICBpZiAoa3MtPmF1dGhlbnRpY2F0ZWQgJiYgcGx1Z2luX2RlZmluZWQgKHNlc3Npb24t
Pm9wdC0+cGx1Z2lucywgT1BFTlZQTl9QTFVHSU5fVExTX0ZJTkFMKSkKICAgICB7CisgICAgICBr
ZXlfc3RhdGVfZXhwb3J0X2tleWluZ19tYXRlcmlhbCgma3MtPmtzX3NzbCwgc2Vzc2lvbik7CisK
ICAgICAgIGlmIChwbHVnaW5fY2FsbCAoc2Vzc2lvbi0+b3B0LT5wbHVnaW5zLCBPUEVOVlBOX1BM
VUdJTl9UTFNfRklOQUwsIE5VTEwsIE5VTEwsIHNlc3Npb24tPm9wdC0+ZXMpICE9IE9QRU5WUE5f
UExVR0lOX0ZVTkNfU1VDQ0VTUykKIAlrcy0+YXV0aGVudGljYXRlZCA9IGZhbHNlOworCisgICAg
ICBzZXRlbnZfZGVsIChzZXNzaW9uLT5vcHQtPmVzLCAiZXhwb3J0ZWRfa2V5aW5nX21hdGVyaWFs
Iik7CiAgICAgfQogCiAgIC8qCmRpZmYgLS1naXQgYS9zcmMvb3BlbnZwbi9zc2xfYmFja2VuZC5o
IGIvc3JjL29wZW52cG4vc3NsX2JhY2tlbmQuaAppbmRleCBiMDc3N2JmLi45OTkzMGU1IDEwMDY0
NAotLS0gYS9zcmMvb3BlbnZwbi9zc2xfYmFja2VuZC5oCisrKyBiL3NyYy9vcGVudnBuL3NzbF9i
YWNrZW5kLmgKQEAgLTMzNCw2ICszMzQsMTkgQEAgdm9pZCBrZXlfc3RhdGVfc3NsX2luaXQoc3Ry
dWN0IGtleV9zdGF0ZV9zc2wgKmtzX3NzbCwKICAqLwogdm9pZCBrZXlfc3RhdGVfc3NsX2ZyZWUo
c3RydWN0IGtleV9zdGF0ZV9zc2wgKmtzX3NzbCk7CiAKKy8qKgorICogS2V5aW5nIE1hdGVyaWFs
IEV4cG9ydGVycyBbUkZDIDU3MDVdIGFsbG93cyBhZGRpdGlvbmFsIGtleWluZyBtYXRlcmlhbCB0
byBiZQorICogZGVyaXZlZCBmcm9tIGV4aXN0aW5nIFRMUyBjaGFubmVsLiBUaGlzIGV4cG9ydGVk
IGtleWluZyBtYXRlcmlhbCBjYW4gdGhlbiBiZQorICogdXNlZCBmb3IgYSB2YXJpZXR5IG9mIHB1
cnBvc2VzLgorICoKKyAqIEBwYXJhbSBrc19zc2wgICAgICAgVGhlIFNTTCBjaGFubmVsJ3Mgc3Rh
dGUgaW5mbworICogQHBhcmFtIHNlc3Npb24gICAgICBUaGUgc2Vzc2lvbiBhc3NvY2lhdGVkIHdp
dGggdGhlIGdpdmVuIGtleV9zdGF0ZQorICovCisKK3ZvaWQKK2tleV9zdGF0ZV9leHBvcnRfa2V5
aW5nX21hdGVyaWFsKHN0cnVjdCBrZXlfc3RhdGVfc3NsICprc19zc2wsCisgICAgc3RydWN0IHRs
c19zZXNzaW9uICpzZXNzaW9uKSBfX2F0dHJpYnV0ZV9fKChub25udWxsKSk7CisKIC8qKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKi8KIC8qKiBAYWRkdG9ncm91cCBjb250cm9sX3RscwogICogIEB7ICovCmRpZmYg
LS1naXQgYS9zcmMvb3BlbnZwbi9zc2xfY29tbW9uLmggYi9zcmMvb3BlbnZwbi9zc2xfY29tbW9u
LmgKaW5kZXggNjIyMmJkNi4uODJlYWZhNiAxMDA2NDQKLS0tIGEvc3JjL29wZW52cG4vc3NsX2Nv
bW1vbi5oCisrKyBiL3NyYy9vcGVudnBuL3NzbF9jb21tb24uaApAQCAtMzE2LDYgKzMxNiwxMSBA
QCBzdHJ1Y3QgdGxzX29wdGlvbnMKIAogICAvKiAtLWdyZW1saW4gYml0cyAqLwogICBpbnQgZ3Jl
bWxpbjsKKworICAvKiBLZXlpbmcgTWF0ZXJpYWwgRXhwb3J0ZXIgW1JGQyA1NzA1XSBwYXJhbWV0
ZXJzICovCisgIGNvbnN0IGNoYXIgKmVrbV9sYWJlbDsKKyAgc2l6ZV90IGVrbV9sYWJlbF9zaXpl
OworICBzaXplX3QgZWttX3NpemU7CiB9OwogCiAvKiogQGFkZHRvZ3JvdXAgY29udHJvbF9wcm9j
ZXNzb3IKZGlmZiAtLWdpdCBhL3NyYy9vcGVudnBuL3NzbF9vcGVuc3NsLmMgYi9zcmMvb3BlbnZw
bi9zc2xfb3BlbnNzbC5jCmluZGV4IGQ5YWJjNmUuLjAzZjY4OWEgMTAwNjQ0Ci0tLSBhL3NyYy9v
cGVudnBuL3NzbF9vcGVuc3NsLmMKKysrIGIvc3JjL29wZW52cG4vc3NsX29wZW5zc2wuYwpAQCAt
MTMzLDYgKzEzMywzOCBAQCBib29sIHRsc19jdHhfaW5pdGlhbGlzZWQoc3RydWN0IHRsc19yb290
X2N0eCAqY3R4KQogICByZXR1cm4gTlVMTCAhPSBjdHgtPmN0eDsKIH0KIAordm9pZAora2V5X3N0
YXRlX2V4cG9ydF9rZXlpbmdfbWF0ZXJpYWwoc3RydWN0IGtleV9zdGF0ZV9zc2wgKnNzbCwKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB0bHNfc2Vzc2lvbiAqc2Vzc2lv
bikKK3sKKyAgaWYgKHNlc3Npb24tPm9wdC0+ZWttX3NpemUgPiAwKQorICAgIHsKKyNpZiAoT1BF
TlNTTF9WRVJTSU9OX05VTUJFUiA+PSAweDEwMDAxMDAwKQorICAgICAgdW5zaWduZWQgY2hhciBl
a21bc2Vzc2lvbi0+b3B0LT5la21fc2l6ZV07CisKKyAgICAgIGlmIChTU0xfZXhwb3J0X2tleWlu
Z19tYXRlcmlhbChzc2wtPnNzbCwgZWttLCBzaXplb2YoZWttKSwKKyAgICAgICAgICBzZXNzaW9u
LT5vcHQtPmVrbV9sYWJlbCwgc2Vzc2lvbi0+b3B0LT5la21fbGFiZWxfc2l6ZSwgTlVMTCwgMCwg
MCkpCisgICAgICAgeworICAgICAgICAgY29uc3QgY2hhciAqZWttX2hleCA9IE5VTEw7CisgICAg
ICAgICBzdHJ1Y3QgZ2NfYXJlbmEgZ2MgPSBnY19uZXcoKTsKKwkgdW5zaWduZWQgaW50IGxlbiA9
IChzZXNzaW9uLT5vcHQtPmVrbV9zaXplICogMikgKyAyOworCisgICAgICAgICBla21faGV4ID0g
Zm9ybWF0X2hleF9leCAoZWttLCBzZXNzaW9uLT5vcHQtPmVrbV9zaXplLCBsZW4sIDAsIE5VTEws
ICZnYyk7CisgICAgICAgICBzZXRlbnZfc3RyIChzZXNzaW9uLT5vcHQtPmVzLCAiZXhwb3J0ZWRf
a2V5aW5nX21hdGVyaWFsIiwgZWttX2hleCk7CisgICAgICAgICBkbXNnKERfVExTX0RFQlVHX01F
RCwgIiVzOiBleHBvcnRlZCBrZXlpbmcgbWF0ZXJpYWw6ICVzIiwgX19mdW5jX18sCisgICAgICAg
ICAgICAgZWttX2hleCk7CisKKyAgICAgICAgIGdjX2ZyZWUoJmdjKTsKKyAgICAgICB9CisgICAg
ICBlbHNlCisgICAgICAgeworICAgICAgICAgbXNnIChNX1dBUk4sICJXQVJOSU5HOiBFeHBvcnQg
a2V5aW5nIG1hdGVyaWFsIGZhaWxlZCEiKTsKKyAgICAgICAgIHNldGVudl9kZWwgKHNlc3Npb24t
Pm9wdC0+ZXMsICJleHBvcnRlZF9rZXlpbmdfbWF0ZXJpYWwiKTsKKyAgICAgICB9CisjZW5kaWYK
KyAgICB9Cit9CisKIC8qCiAgKiBQcmludCBkZWJ1Z2dpbmcgaW5mb3JtYXRpb24gb24gU1NML1RM
UyBzZXNzaW9uIG5lZ290aWF0aW9uLgogICovCmRpZmYgLS1naXQgYS9zcmMvb3BlbnZwbi9zc2xf
cG9sYXJzc2wuYyBiL3NyYy9vcGVudnBuL3NzbF9wb2xhcnNzbC5jCmluZGV4IDhjYjMyOGUuLjNi
OTk5YjAgMTAwNjQ0Ci0tLSBhL3NyYy9vcGVudnBuL3NzbF9wb2xhcnNzbC5jCisrKyBiL3NyYy9v
cGVudnBuL3NzbF9wb2xhcnNzbC5jCkBAIC0xNDksNiArMTQ5LDEyIEBAIHRsc19jdHhfaW5pdGlh
bGlzZWQoc3RydWN0IHRsc19yb290X2N0eCAqY3R4KQogfQogCiB2b2lkCitrZXlfc3RhdGVfZXhw
b3J0X2tleWluZ19tYXRlcmlhbChzdHJ1Y3Qga2V5X3N0YXRlX3NzbCAqc3NsLAorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHRsc19zZXNzaW9uICpzZXNzaW9uKQorewor
fQorCit2b2lkCiB0bHNfY3R4X3NldF9vcHRpb25zIChzdHJ1Y3QgdGxzX3Jvb3RfY3R4ICpjdHgs
IHVuc2lnbmVkIGludCBzc2xfZmxhZ3MpCiB7CiB9Ci0tIAoxLjcuMQoK
--001a11c2d2ea28bdfa0510def5a3--

