Message-ID: <af0497ca-b862-6a5c-f5ff-eb0d34a84692@...1227...>
Date: Sun, 15 Jan 2023 05:23:26 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <6c0e8ca1-9518-1bc0-65cb-f742311ef08f@...1227...>
 <f52172ec20da430975373e7192380874bc600062.camel@...2316...>
 <43485320-4957-8ac1-7bab-4e769000d156@...1227...>
 <234ef71a00e43f74bda0836d66c63a3d8c54a74c.camel@...2316...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <234ef71a00e43f74bda0836d66c63a3d8c54a74c.camel@...2316...>
Subject: Re: [Openvpn-devel] Amend OpenVPN license to allow continued mbed
 TLS support (allow mbed TLS 3.x linking)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: James Bottomley <James.Bottomley@...2316...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

>>   Also for platforms like Android,  Windows and macOS we are shipping
>> OpenSSL and mbed TLS ourselves since  they are NOT provided by the
>> system.
> 
> Would I be correct in assuming that the "we" here isn't the openvpn
> project and is, in fact, some corporation that wants legal cover for
> its business model?

OpenVPN project ships the Windows GUI. I personally build/ship the 
OpenVPN for Android open source app. The commercial OpenVPN inc 
offerings are actually not affected since they use a C++ 
reimplementation of OpenVPN. There are also other companies that use 
OpenVPN in commercial products that benefit from a clarified license.

> So I think the actual issue is, to take the Android example, that
> Android has a native system crypto library (openssl on early android
> and boringssl on later) but you want to use a different system library
> that's not part of the standard distribution.   If you're using
> something that is a system library on another distributions and it's
> only substituting for functionality that would be provided by the
> native system library, It's obviously a greyer legal area but I'd say
> you're still covered by the system library exception.

I do not think we are covered by the system library exception and even 
if it is a grey area, it would be good to make this a non-gray area by 
modifying our license to explicitly allow it.

isn't talking about linking them
>>> together.

>>> If you or anyone else needs an Open Source counsel to give advice
>>> to the OpenVPN project about these differences and the standard
>>> practice today, I can arrange for that to happen.
> 
> OK, so I obviously can't arrange this pro-bono for a for-profit entity,
> but I can recommend some great open source legal people who may be
> prepared to consult.

What you are presenting here is completely different than what I (and 
others) have been told in this matter. So while I am not adverse to 
getting another opinion I am a bit hesitant to do so since far other 
legal advice had been pretty consistent.
>> That what you saying it contrary to what I have seen. Can you give a
>> source that states that combining GPL2 and Apache2 into one binary
>> and shipping that is legal?
> 
> What do you mean "a source"? every apache licensed library that's
> statically linked with a GPLv2 program would be an example of this ...

Yes and to my understanding doing this violates the licenses. Just 
because people are not checking license compatibility and doing this 
does not mean that this does not violate the licenses.

> in the early days there was no dynamic linking, so all the early GNU
> tools were statically linked with wodges of proprietary binary gunk.

Yes. But these were libraries shipped with the system. In contrast here 
we are shipping OpenSSL/mbed TLS ourselves.

> Even if, for the sake of argument, I assume that what you're doing
> isn't covered by the system library exception, then what you're
> proposing doesn't fix your problem.  Your problem becomes section 2 of
> the GPLv2: you must distribute the whole thing under GPLv2.  No amount
> of permissions to link can get you out of this if, as you're assuming,
> Apache-2 and GPLv2 are incompatible because you're still required to
> ship an Apache-2 piece (mbedtld) under GPLv2.  You would have to frame
> your additional license permission as an exception to the section 2
> requirement to distribute the whole under GPLv2

I am confused here. The proposed paragraph is phrased that it is a 
special exception that allows doing this. The paragraph explicitly 
states that we allow as a special exception to distribute the binaries 
containing the Apache2 library and the OpenVPN code. This uses the same 
wording as the existing OpenSSL exception.

We can probably change the wording to something different but even the 
FAQ of the GNU project that uses different wording does not explicitly 
mention the section of the GPLv2 (from 
https://www.gnu.org/licenses/gpl-faq.html#GPLIncompatibleLibs):

In addition, as a special exception, the copyright holders of [name of 
your program] give you permission to combine [name of your program] with 
free software programs or libraries that are released under the GNU LGPL 
and with code included in the standard release of [name of library] 
under the [name of library's license] (or modified versions of such 
code, with unchanged license). You may copy and distribute such a system 
following the terms of the GNU GPL for [name of your program] and the 
licenses of the other code concerned.


While the text of the FSF is different and includes some LGPL wording it 
is similar to our texts and while the details are different, I don't see 
anything fundamentally different in their version from ours.

Arne

