MIME-Version: 1.0
In-Reply-To: <CAEsd45S3fcLOR0vYgA1ydR1muAG=sNzSqbSRj+ZmtBp692hJow@...278...>
References: <4F438CF2.1060305@...515...>
	<CAEsd45Rw5nYYuMMq_Qy_5tQYagZh+EMHM+2Nugod1_1s-BHthA@...278...>
	<4F44F7F8.4090604@...1114...>
	<eb2837a3-ce55-4f52-b2fe-f822efc661f7@...1662...>
	<CAEsd45S3fcLOR0vYgA1ydR1muAG=sNzSqbSRj+ZmtBp692hJow@...278...>
Date: Thu, 23 Feb 2012 08:11:03 +0100
Message-ID: <CAOBzU4MJdJBzfgo98sAVG732OBXGR2KVS-ZFxXBCbZXZr7C+9w@...278...>
From: Frank de Brabander <debrabander@...277...>
Subject: Re: [Openvpn-devel] OpenVPN 2.3-alpha1 preview 1 installer now
	available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Maybe you already know this, but I want to point it out just in case;
pkcs11-helper library is not included in OS X. You need to build that
first, if you want to include support for this in openvpn.

Op 22 februari 2012 23:23 heeft Jonathan K. Bullard
<jkbullard@...277...> het volgende geschreven:
> On Wed, Feb 22, 2012 at 2:49 PM, debrabander <debrabander@...277...> wrote:
>> This is not the a problem when building using the latest Mac OS X SDK.
>> I've did a quick search and it seems to be a more common issue on some
>> (old) Darwin platforms. Please try building again after applying the
>> patch below.
>
> Your patch fixed the error, so thank you very much!
>
> I gather the patch was from a slightly different version of socket.c,
> since the line numbers were a few lines off of what I have. But it
> seemed to work.
>
> Now I need to figure out what is causing the warnings about vararg, a
> bunch of "differ in signedness" warnings, and a "ld: library not found
> for -lpkcs11-helper" error. I'll try using more recent SDKs.
>
> Thanks again.

