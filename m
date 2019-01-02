References: <99D61A626FDA8A4B90A270669121BE109BE8AA4C@...2294...>
 <76addf9c-a14e-0e59-bb01-dace07b56a03@...277...>
 <775f6ca7-227f-6ae9-2206-1fa3d11b6376@...277...>
 <5aa26403-9948-df7a-6eaa-a6c1d0ba0a29@...277...>
 <99D61A626FDA8A4B90A270669121BE109BE8D349@...2294...>
 <CC83ED38-544A-4750-8AD0-6E5B60141864@...2293...>
 <a9509aa8-559c-9abc-db30-b3588bb2b6e1@...277...>
 <b3c46f54-fc61-80c8-a8c8-328e2bb1f9af@...277...>
 <10B663D4-5299-4299-A6F7-D3DFEBD1FA44@...2293...>
 <20190102184634.GE962@...1296...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <7b9621a3-e80d-f151-91db-cc44047c7522@...277...>
Date: Wed, 2 Jan 2019 19:26:48 +0000
MIME-Version: 1.0
In-Reply-To: <20190102184634.GE962@...1296...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [Help required] Testing MSI installations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>



On 02/01/2019 18:46, Gert Doering wrote:
> Hi,
> 
> On Wed, Jan 02, 2019 at 04:37:33PM +0000, Simon Rozman wrote:
>>> Even though there are errors reported the VPN still works for both
>>> IPv4 and 6 with both versions of the binary.
>>
>> Probably a patch between 2.4.6 from 26/Apr/2018 and 2.4.6-m4 from 1/Jan/2019 introduced an error-level check after the netsh.exe interface ipv6 add route call.
> 
> Not that I'm aware of (re-read "git log release/2.4" to be sure).   We added
> "turn on dhcp via iservice" support, but that's not "add route".
> 
> So it's likely something else.  Need to look at the details in the log
> (what is pushed, how is netsh called, what is failing?).
> 
Sorry, this was probably my own fault ..

My best guess is this may have been something to do with me
saving/restoring the VM.

I re-installed your m4 and then tried with my git_master and cannot
reproduce the route failures.  Tried a few re-installs etc ..

While testing different installs I found that the installer failed to
uninstall the openvpn Legacy service once, but I tried so many different
combinations of uninstall/new install vs install over a running process
that one small glitch, which err'd out correctly with user press cancel,
that I don't think it is worth worrying about.
(I was trying to break it deliberately)

Overall, the 32b installer from .exe seems to work well.


Sorry about the VM thing :-)

