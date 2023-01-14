Message-ID: <f52172ec20da430975373e7192380874bc600062.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Sat, 14 Jan 2023 14:57:00 -0500
In-Reply-To: <6c0e8ca1-9518-1bc0-65cb-f742311ef08f@...1227...>
References: <6c0e8ca1-9518-1bc0-65cb-f742311ef08f@...1227...>
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

On Sat, 2023-01-14 at 18:29 +0100, Arne Schwabe wrote:
> Hey,
> 
> This is the first round and will be only to the openvpn-devel list. 
> After that I will also write to individuals email addresses but I
> want to start with sending this to the devel list.
> 
> We are writing to you since you are or were a contributor in past to 
> OpenVPN and we would like to  ask for your permission to amend the 
> license of OpenVPN.
> 
> OpenVPN 2.x is licensed under the GPL v2. This license has served us 
> well in the past and we are not trying to change that. However,
> changes in licenses of our dependencies make this change necessary.
> 
> Both mbed TLS and OpenSSL nowadays use the Apache 2.x license. For
> the OpenSSL library we have a special exception that allows us
> linking with it. For newer mbed TLS version, we cannot do this any
> more. 

I think there's been a misunderstanding here: there's no barrier to
*linking* any GPLv2 licensed program with a system library whatever the
library licence is.  This dates back to the earliest days of the GNU
project when the initial design was for all the GNU tools to be built
and run on proprietary UNIX system regardless of system library licence
(which was always proprietary), and is specifically what the GPL system
library exception was designed to cover.

> Compatibility of Apache 2.x and GPL 2.x has to our knowledge never
> been tested in court and even FSF and ASF disagree about the issue 
> (https://www.apache.org/licenses/GPL-compatibility.html)

That's talking about compatibility when cutting and pasting code or
including source files from an Apache licensed project into a GPLv2
licensed project, it definitely isn't talking about linking them
together.

If you or anyone else needs an Open Source counsel to give advice to
the OpenVPN project about these differences and the standard practice
today, I can arrange for that to happen.

James


