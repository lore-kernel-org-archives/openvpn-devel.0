References: <1497872853-1464-1-git-send-email-steffan.karger@...1435...>
	<20170621201753.GA31123@...2287...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <62da7142-d087-7d89-5974-7533b1be0713@...1856...>
Date: Wed, 21 Jun 2017 23:09:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170621201753.GA31123@...2287...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Move adjust_power_of_2() to integer.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 21-06-17 22:17, Antonio Quartulli wrote:
> However, now that adjust_power_of_2() has been moved to integer.h, shouldn't
> this file be included by every .c where the function is used? Or do we have some
> other rule about header files inclusion?
> 
> Personally I prefer when every .c file directly includes the .h it relies on,
> without assuming any indirect inclusion. What's the common habit here?

We have no consistent rule or habit that I know of, but I fully agree
with you.  So thanks for paying attention, will send a v2 in a minute.

-Steffan

