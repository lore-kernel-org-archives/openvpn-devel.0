References: <CAKuzo_g1yJwUsVdUF+RJdO6DeHeVhYOhSgWLX-SoFfiUw3o2sQ@...278...>
 <29a3b6b5-f596-0c63-9a37-377399e1e4d0@...515...>
 <CAKuzo_iVMAAjPR-GLE0s+unhowhq6uxUPzD0f1S1mYZAsZkDng@...278...>
 <CAKuzo_jYRJPnZmKpdbMwC1L=96+f_rRT3TtKbSPF61pPen64fw@...278...>
 <CAKuzo_ib6XmtzOVtd4FzHSJRunPRRYEQA3hH+svx=n-V18Qx-A@...278...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <03afef7f-c193-c209-92cb-2422754dcb2b@...277...>
Date: Mon, 18 Jun 2018 18:10:11 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_ib6XmtzOVtd4FzHSJRunPRRYEQA3hH+svx=n-V18Qx-A@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] interactive service docs
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Selva,

just a note that:


- ``--up`` scripts are run by openvpn.exe itself, which is running as user
   *joe*, all privileges are nicely in place.

- Scripts run by the GUI will run as user *joe*, so that automated tasks 
like
   *mapping of drives* work as expected.


As far as I know, mapping network drives from an --up script does NOT
work because the VPN will not pass any data until all scripts complete.

So is this really a suitable example ?

Regards





On 18/06/18 17:09, Selva Nair wrote:
> On Tue, Jun 12, 2018 at 12:39 PM, Selva Nair <selva.nair@...277...> wrote:
> 
>> Hi,
>>
>>
>>>> However, Trac supports RST natively:
>>>>
>>>> {{{#!rst
>>>> RST-formatted contents go in here
>>>> }}}
>>>>
>>>
>>>> For details see
>>>>
>>>> https://trac.edgewall.org/wiki/WikiProcessors
>>>> https://trac.edgewall.org/wiki/WikiRestructuredText
>>>>
>>>> Based on quick test it seems to work:
>>>>
>>>> https://community.openvpn.net/openvpn/wiki/RstTest
>>>>
>>>> Note that "preview" window does not show the end results but raw RST.
>>>> This seems to be a feature/bug of Trac WikiProcessors in general.
>>>>
>>>
>>> Thanks for tip. I've now updated the original page by embedding the rst
>>> content as {{{#!rst  }}}.
>>>
>>> https://community.openvpn.net/openvpn/wiki/OpenVPNInteractiveService
>>>
>>
>>
>> This edit is now missing. Was trac pages reloaded from backup or some such?
>>
> 
> Assuming the trac is fully back now, I recreated this page (text embedded
> with rst shebang).
> 
> However the it displays as raw rst now. Did the rst processor got disabled?
> Or is it just my browser? The edited page is:
> 
> https://community.openvpn.net/openvpn/wiki/OpenVPNInteractiveService
> 
> I have not reverted the edit as even without formatting the content is kind
> of readable.
> 
> Selva
> 
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

