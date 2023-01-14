Message-ID: <234ef71a00e43f74bda0836d66c63a3d8c54a74c.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Sat, 14 Jan 2023 17:28:09 -0500
In-Reply-To: <43485320-4957-8ac1-7bab-4e769000d156@...1227...>
References: <6c0e8ca1-9518-1bc0-65cb-f742311ef08f@...1227...>
 <f52172ec20da430975373e7192380874bc600062.camel@...2316...>
 <43485320-4957-8ac1-7bab-4e769000d156@...1227...>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Sat, 2023-01-14 at 21:34 +0100, Arne Schwabe wrote:
> Am 14.01.2023 um 20:57 schrieb James Bottomley:
> > On Sat, 2023-01-14 at 18:29 +0100, Arne Schwabe wrote:
> > > Hey,
> > > 
> > > This is the first round and will be only to the openvpn-devel
> > > list. After that I will also write to individuals email addresses
> > > but I want to start with sending this to the devel list.
> > > 
> > > We are writing to you since you are or were a contributor in past
> > > to OpenVPN and we would like to  ask for your permission to amend
> > > the license of OpenVPN.
> > > 
> > > OpenVPN 2.x is licensed under the GPL v2. This license has served
> > > us well in the past and we are not trying to change that.
> > > However, changes in licenses of our dependencies make this change
> > > necessary.
> > > 
> > > Both mbed TLS and OpenSSL nowadays use the Apache 2.x license.
> > > For the OpenSSL library we have a special exception that allows
> > > us linking with it. For newer mbed TLS version, we cannot do this
> > > any more.
> >  
> > I think there's been a misunderstanding here: there's no barrier to
> > *linking* any GPLv2 licensed program with a system library whatever
> > the library licence is.
> 
> mbed TLS is not a system library.

Of course it is; it's designed to be a lightweight substitute for
openssl in certain small footprint situations and it's shipped pretty
much by every Linux distribution that wants to play in embedded.

>  Also for platforms like Android,  Windows and macOS we are shipping
> OpenSSL and mbed TLS ourselves since  they are NOT provided by the
> system.

Would I be correct in assuming that the "we" here isn't the openvpn
project and is, in fact, some corporation that wants legal cover for
its business model?

So I think the actual issue is, to take the Android example, that
Android has a native system crypto library (openssl on early android
and boringssl on later) but you want to use a different system library
that's not part of the standard distribution.   If you're using
something that is a system library on another distributions and it's
only substituting for functionality that would be provided by the
native system library, It's obviously a greyer legal area but I'd say
you're still covered by the system library exception.

> > This dates back to the earliest days of the GNU project when the
> > initial design was for all the GNU tools to be built and run on
> > proprietary UNIX system regardless of system library licence
> > (which was always proprietary), and is specifically what the GPL
> > system library exception was designed to cover.
> > 
> > > Compatibility of Apache 2.x and GPL 2.x has to our knowledge
> > > never been tested in court and even FSF and ASF disagree about
> > > the issue(https://www.apache.org/licenses/GPL-compatibility.html)
> >  
> > That's talking about compatibility when cutting and pasting code or
> > including source files from an Apache licensed project into a GPLv2
> > licensed project, it definitely isn't talking about linking them
> > together.
> > 
> > If you or anyone else needs an Open Source counsel to give advice
> > to the OpenVPN project about these differences and the standard
> > practice today, I can arrange for that to happen.

OK, so I obviously can't arrange this pro-bono for a for-profit entity,
but I can recommend some great open source legal people who may be
prepared to consult.

> That what you saying it contrary to what I have seen. Can you give a
> source that states that combining GPL2 and Apache2 into one binary
> and shipping that is legal?

What do you mean "a source"? every apache licensed library that's
statically linked with a GPLv2 program would be an example of this ...
in the early days there was no dynamic linking, so all the early GNU
tools were statically linked with wodges of proprietary binary gunk.

Even if, for the sake of argument, I assume that what you're doing
isn't covered by the system library exception, then what you're
proposing doesn't fix your problem.  Your problem becomes section 2 of
the GPLv2: you must distribute the whole thing under GPLv2.  No amount
of permissions to link can get you out of this if, as you're assuming,
Apache-2 and GPLv2 are incompatible because you're still required to
ship an Apache-2 piece (mbedtld) under GPLv2.  You would have to frame
your additional license permission as an exception to the section 2
requirement to distribute the whole under GPLv2.

James



