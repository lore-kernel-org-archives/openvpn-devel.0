References: <20210512131511.1309914-1-arne@...1227...>
 <20210512131511.1309914-10-arne@...1227...>
 <c21f848a-adb1-88b3-7d7f-b8fb3152f617@...2080...>
 <42ed2aef-ebca-073c-734a-3c7cc5d09a58@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5be3ba49-73c0-2294-94af-2f03ed16e1f2@...2080...>
Date: Sat, 15 May 2021 00:32:22 +0200
MIME-Version: 1.0
In-Reply-To: <42ed2aef-ebca-073c-734a-3c7cc5d09a58@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 9/9] Add detailed man page section to
 setup a OpenVPN setup with peer-fingerprint
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 14/05/2021 15:57, Arne Schwabe wrote:
> 
>>> +++ b/doc/Makefile.am
>>> @@ -25,6 +25,7 @@ dist_noinst_DATA = \
>>>        man-sections/connection-profiles.rst \
>>>        man-sections/encryption-options.rst \
>>>        man-sections/examples.rst \
>>> +    man-sections/examples.rst \
>>
>> I suspect you intended to add doc/man-sections/example-fingerprint.rst
>> instead of adding examples.rst twice.
>>
>> To make this file appear in the openvpn(8) man page, you also need to
>> include it from doc/openvpn.8.rst.
>>
>> Maybe we should also consider moving all these configuration examples
>> out of the main openvpn(8) man page and into a openvpn-examples(7) man
>> page.  This can be done after this change, though.
>>
>>
> 
> We can also make that a patch before this patch in the patch set.
> However, I haven't looked at all the man page generation magic to
> understand how hard it would be to create an extra man page.

Most of the magic happens in openvpn.8.rst.  We facilitate the 
..include:: statement to "glue" together the main man page from all the 
files in man-sections/.  And this is all parsed and handled by rst2man 
and rst2html.

The Makefile.am ensures the openvpn.8 and openvpn.8.html are properly 
built when it should.  We're doing a little trick with a dist-hook, so 
these files are prebuilt and packaged when running 'make dist' and 'make 
distcheck', which ensures prebuilt man page files (groff and html) are 
packaged into the source tarball.  And these files are normally not 
rebuilt unless missing.

In Makefile.am it could be created some more generic %.8 and %.8.html 
rules, also for the man 7 page section.  And then the main framework 
should be in in place.

A nice touch could be though to extract the ..include:: statements from 
the .rst files we're building to generate the file list for 
dist_noinst_DATA automatically, as I consider this the most fragile 
aspect.  It could probably also be done the other way too (Makefile.am 
generating an .rst include file before the main rst2{html,man} run), but 
I consider this less preferred as then the order of section is defined 
inside Makefile.am and not a document file itself.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


