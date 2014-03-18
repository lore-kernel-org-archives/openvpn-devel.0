Message-ID: <53281720.2050504@...1147...>
Date: Tue, 18 Mar 2014 10:51:28 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1395017376-24554-1-git-send-email-james@...515...>	<20140317202910.GM16637@...1296...>
	<532775DD.4050106@...515...>
	<1CED409804E2164C8104F9E623B08B90155646D4C1@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B90155646D4C1@...1436...>
Subject: Re: [Openvpn-devel] [PATCH] Set SSL_OP_NO_TICKET flag in SSL
 context for OpenSSL builds, to disable TLS stateless session resumption.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan.karger@...1435...>, James Yonan <james@...515...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 18/03/14 10:39, Steffan Karger wrote:
> Hi,
>
>> On 17/03/2014 23:23, James Yonan wrote:
>>
>> On 17/03/2014 14:29, Gert Doering wrote:
>>> Right now, if I read configure.ac correct, we require 0.9.6 or later
>>> (and check this only if pkg-config is available) - but obviously,
>>> SSL_OP_NO_TICKET was added later on.
>>>
>>> Fix 1: only use SSL_OP_NO_TICKET if available Fix 2: require a more
>>> recent OpenSSL version
>> I would think an #ifdef should be fine.
> SSL_OP_NO_TICKET was added in OpenSSL 0.9.8f / 1.0.0. The ECDH-patchset (for 2.4) already requires 0.9.8, so I would prefer to require 0.9.8f or newer for master/2.4, but just add #ifdef's for 2.3.
>
>
I disagree. It is not safe to assume that the #ifdef is bound to a 
particular version of Openssl; for example, on my Centos 6.5 box I have 
openssl 1.0.1e yet the define
   #define SSL_OP_NO_TICKET                0x00004000L
is NOT present in the system ssl.h file.
Don't ask me why, don't question the sanity of CentOS/RedHat, don't 
assume that "openssl vX.Y.Z will have support for ...."
(RedHat also strips ECDH support from openssl due to claimed licensing 
restrictions).

Let's just check for the #ifdef regardless of the version of OpenSSL.

cheers,

JJK


