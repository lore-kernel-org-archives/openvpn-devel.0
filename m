References: <20210512131511.1309914-1-arne@...1227...>
 <20210512131511.1309914-10-arne@...1227...>
 <c21f848a-adb1-88b3-7d7f-b8fb3152f617@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <42ed2aef-ebca-073c-734a-3c7cc5d09a58@...1227...>
Date: Fri, 14 May 2021 15:57:16 +0200
MIME-Version: 1.0
In-Reply-To: <c21f848a-adb1-88b3-7d7f-b8fb3152f617@...2080...>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net


>> +++ b/doc/Makefile.am
>> @@ -25,6 +25,7 @@ dist_noinst_DATA = \
>>       man-sections/connection-profiles.rst \
>>       man-sections/encryption-options.rst \
>>       man-sections/examples.rst \
>> +    man-sections/examples.rst \
> 
> I suspect you intended to add doc/man-sections/example-fingerprint.rst
> instead of adding examples.rst twice.
> 
> To make this file appear in the openvpn(8) man page, you also need to
> include it from doc/openvpn.8.rst.
> 
> Maybe we should also consider moving all these configuration examples
> out of the main openvpn(8) man page and into a openvpn-examples(7) man
> page.  This can be done after this change, though.
> 
> 

We can also make that a patch before this patch in the patch set.
However, I haven't looked at all the man page generation magic to
understand how hard it would be to create an extra man page.

Arne

