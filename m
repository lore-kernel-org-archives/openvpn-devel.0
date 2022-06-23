Message-ID: <e95c3934-9d05-7760-8cd5-bb42268a7ce8@...2080...>
Date: Thu, 23 Jun 2022 20:39:47 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20200106080426.40701-1-list@...1798...>
From: David Sommerseth <openvpn@...2080...>
In-Reply-To: <20200106080426.40701-1-list@...1798...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] configure.ac: replace set with env
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
To: Christian Hesse <list@...1798...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 06/01/2020 09:04, Christian Hesse wrote:
> From: Christian Hesse <mail@...1798...>
> 
> The shell builtin `set` produces different output for different shells:
> 
> bash$ set | grep '^TERM='
> TERM=xterm
> dash$ set | grep '^TERM='
> TERM='xterm'
> 
> This may break reproducible builds depending on what shell is used.
> 
> Let's replace `set` with `env`, which is a real command and always
> produces identical output.

Hi,

Spotted this one now, lingering for way too long.  And it looked 
trivial.  Except it doesn't give the expected outcome on my RHEL-8 
machine.  The CONFIGURE_DEFINES macro in config.h ends up empty. 
Reverting this patch alone, and it comes back again.

So, I'm sorry, I can't ack this one.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


