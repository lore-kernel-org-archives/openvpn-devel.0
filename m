Message-ID: <447f3ac8-99a3-8639-bada-9acff5dd1605@...1227...>
Date: Thu, 6 Oct 2022 10:40:42 +0200
MIME-Version: 1.0
References: <20220909195902.2011798-1-arne@...1227...>
 <20220909195902.2011798-2-arne@...1227...> <Yz3muBEdbTSo13qX@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <Yz3muBEdbTSo13qX@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Use buffer to prepare
 protocol-flags push-reply
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net


Am 05.10.2022 um 22:19 schrieb Gert Doering:
> Hi,
>
> On Fri, Sep 09, 2022 at 09:59:01PM +0200, Arne Schwabe wrote:
>> The current approach of checking a string buffer is a bit clunky and
>> also not very extensible. Refactor this by collecting the flags in
>> a buffer.
> I think that this one is obsolete, aka, already included in
>
> commit 179b3728b71013413885e453e477997f5a396f78
> Author: Arne Schwabe <arne@...1227...>
> Date:   Wed Sep 14 18:50:41 2022 +0200
>
>      Implement exit notification via control channel
>
>      Patch v4: rebase, use a buffer for the code that prepares the push reply
>
> can you confirm?

Yes. You are right. During the rebase of cc exit, I included it there.

Arne


