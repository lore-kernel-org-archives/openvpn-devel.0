References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<CAKuzo_gH06N2yip+h-=Q_w1xpyP62d6v4-7=Bb2NK-=+ji6iKw@...278...>
	<41cb24fe-1439-25bb-9e9e-6cbfa4523ba9@...1856...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <550d2633-58a8-7574-b6b6-a8c4af3d6c78@...1856...>
Date: Thu, 8 Dec 2016 23:45:13 +0100
MIME-Version: 1.0
In-Reply-To: <41cb24fe-1439-25bb-9e9e-6cbfa4523ba9@...1856...>
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 08-12-16 23:24, Steffan Karger wrote:
> On 08-12-16 22:56, Selva Nair wrote:
>> Reformatted tun.c has at least two instances of char* xxx, we want char
>> *xxx, right? So why not add some sp_xxx_ptr_star options.
> 
> We settled for char *xxx yesterday, so I'll add that.
> 
>> Less of a concern at least for me is function_name (...) and
>> function_name(...) both appears to be allowed. Just because we can do
>> it, why not add some sp_func_xxxx_paren options to normalize those.
> 
> Agreed.  Allman (at least according to the wikipedia examples) uses
> funcion_name(), so I'll add that too.
> 
> I'll update the options on the CodeStyle page.

Done, new tun.c example here:
https://paste.fedoraproject.org/502063/36953148/

-Steffan

