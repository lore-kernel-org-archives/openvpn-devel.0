MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <20170219174934.GK93896@...1296...>
References: <cover.1487368114.git.logout@...260...>
	<3b87d588-aad7-433d-f802-ea9f9f7a0a63@...1856...>
	<20170219174934.GK93896@...1296...>
From: Emmanuel Deloget <logout@...260...>
Date: Mon, 20 Feb 2017 12:45:24 +0100
Message-ID: <CAKh=nwGOyR6reYpPvxqFVRKGDhpn7fLmw-GNBjMy=bJrqKTPmw@...278...>
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

Hello,

On Sun, Feb 19, 2017 at 6:49 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Sun, Feb 19, 2017 at 01:03:45PM +0100, Steffan Karger wrote:
>> Thank you very much.  You approach looks good to me, and quite closely
>> matches what I had in mind for when I would find the time to tackle
>> this.  (Which might have taken me a while, so really happy to see these
>> patches!)
> [..]
>> Also very good that this is split up into small and independently
>> reviewable patches.  I'll start review soon.
>
> While Steffan is our resident expert on nasty crypto libraries, I just
> want to echo the sentiment - having these "chunks" tackle one API function
> at a time, they are easily testable, and in case something explodes, it's
> much easier to bisect to find the problematic one.
>
> Now back to being a commit slave for Steffan's ACKs :-)  (I do not know
> the APIs well enough to properly comment on the changes, I can only run
> tests...)

I resumed the work this morning. So far the results are :

* 0.9.8zh --> EVP_PKEY_id() is not defined. I'm adding this to
openssl_compat.h and will provide a v2 patch with the change. Once
added, OpenVPN compiled successfully and was able to connect to my
/2.3 server.

* 1.0.0t --> compile OK, connect OK

* 1.0.1u --> compile OK, connect OK

* 1.0.2.k --> compile OK, connect OK

* 1.1.0-git --> compile OK, failure to connect. I'm currently
investigating this issue. I'll  provide a patch as soon as I fix this
(this is a bit ironic ; I may have forgotten something somewhere...).

I don't have much time to test with other OpenSSL versions but I guess
you have the infrastructure that will help.

> gert

Best regards,

-- Emmanuel Deloget

