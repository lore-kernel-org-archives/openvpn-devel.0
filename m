MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <20170220123711.GX93896@...1296...>
References: <cover.1487368114.git.logout@...260...>
	<3b87d588-aad7-433d-f802-ea9f9f7a0a63@...1856...>
	<20170219174934.GK93896@...1296...>
	<CAKh=nwGOyR6reYpPvxqFVRKGDhpn7fLmw-GNBjMy=bJrqKTPmw@...278...>
	<20170220123711.GX93896@...1296...>
From: Emmanuel Deloget <logout@...260...>
Date: Mon, 20 Feb 2017 14:38:12 +0100
Message-ID: <CAKh=nwHu5GFd6rDsDzeTUdocOziBM1c+mKMSTLaMVnppnCV+pA@...278...>
Subject: Re: [Openvpn-devel] [RFC PATCH v1 00/15] Add support for OpenSSL
	1.1.x
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Mon, Feb 20, 2017 at 1:37 PM, Gert Doering <gert@...1296...> wrote:
>
> Interesting.  Anything useful in openvpn's logs?
>

Mon Feb 20 11:57:56 2017 us=371715 OpenSSL: error:0607B083:digital
envelope routines:EVP_CipherInit_ex:no cipher set
Mon Feb 20 11:57:56 2017 us=371746 EVP cipher init #2

I found the culprit: OpenSSL's EVP_CipherInit() changed way too much
for a 3 lines function. Prior to v1.1, the code did a check on cipher
parameter and cleared the EVP context only if cipher was not null. In
1.1, it clears the context unconditionnaly. Having to cope with
changes in the interface is not that fun, having to cope with behavior
changes is even worse :)

I'm producing an additional commit to work around that change (the
proposed change does not depend on the OpenSSL version).

>> I don't have much time to test with other OpenSSL versions but I guess
>> you have the infrastructure that will help.
>
> Well, *I* do not have specific "test across various OpenSSL versions"
> infrastructure, but compiling across our buildbot zoo gives us quite a
> bit of coverage...  and I assume Steffan has more coverage on SSL library
> versions.
>
> thanks for your work!
>
> gert

Well, thanks to everyone involved -- all of you have been really kind
with me (for now :))

Best regards,

-- Emmanuel Deloget

