MIME-Version: 1.0
In-Reply-To: <bbc21eb4-67bb-cd2c-b01f-55ad730d7db0@...2080...>
References: <1481827955-18896-1-git-send-email-steffan@...1856...>
	<bbc21eb4-67bb-cd2c-b01f-55ad730d7db0@...2080...>
From: Steffan Karger <steffan@...1856...>
Date: Thu, 15 Dec 2016 22:43:03 +0100
Message-ID: <CAA1Abx+5B1b+ezGWt5YnyLz_MNVVyNJXitKWttScnA5yi9grZQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Don't reopen tun if cipher changes
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 15 December 2016 at 20:49, David Sommerseth
<openvpn@...2080...> wrote:
> On 15/12/16 19:52, Steffan Karger wrote:
>> -        if (strstr(line, "peer-id ") != line)
>> +        if (strcmp(line, "peer-id ") == 0)
>
> Are you sure about this strcmp()?  I'd expect line to contain
> "peer-id 1" or something like that ... so the result would be 49 (or
> anything not 0) .... strncmp(line, "peer-id ", 8) would provide a match
> though.

Hrmpf, you're absolutely right.  That's what I get for rushing out a
patch.  I'll send a v2 shortly.

-Steffan

