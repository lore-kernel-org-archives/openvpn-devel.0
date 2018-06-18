References: <CAKuzo_g1yJwUsVdUF+RJdO6DeHeVhYOhSgWLX-SoFfiUw3o2sQ@...278...>
 <29a3b6b5-f596-0c63-9a37-377399e1e4d0@...515...>
 <CAKuzo_iVMAAjPR-GLE0s+unhowhq6uxUPzD0f1S1mYZAsZkDng@...278...>
 <CAKuzo_jYRJPnZmKpdbMwC1L=96+f_rRT3TtKbSPF61pPen64fw@...278...>
 <CAKuzo_ib6XmtzOVtd4FzHSJRunPRRYEQA3hH+svx=n-V18Qx-A@...278...>
 <03afef7f-c193-c209-92cb-2422754dcb2b@...277...>
 <CAKuzo_i76hZ6MHrC2qoTe1UttyB=8-Qz7t1ADHk=Cqi-EpbKQA@...278...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <230b009f-b9dd-6d32-83f3-6a298621a06f@...277...>
Date: Mon, 18 Jun 2018 21:02:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_i76hZ6MHrC2qoTe1UttyB=8-Qz7t1ADHk=Cqi-EpbKQA@...278...>
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
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 18/06/18 19:17, Selva Nair wrote:
> Hi,
> 
> On Mon, Jun 18, 2018 at 1:10 PM, tincanteksup <tincanteksup@...277...>
> wrote:
> 
>> Hi Selva,
>>
>> just a note that:
>>
>>
>> - ``--up`` scripts are run by openvpn.exe itself, which is running as user
>>    *joe*, all privileges are nicely in place.
>>
>> - Scripts run by the GUI will run as user *joe*, so that automated tasks
>> like
>>    *mapping of drives* work as expected.
>>
>>
>> As far as I know, mapping network drives from an --up script does NOT
>> work because the VPN will not pass any data until all scripts complete.
>>
>> So is this really a suitable example ?
>>
> 
> This is about up script run by the GUI (profile_name_up.bat) and works
> nicely for mapping drives. We use it widely for our Windows users.
> 

Thanks for clarifying that it is NOT an --up script in this case ..

The document you are looking for can also be found here:
https://community.openvpn.net/openvpn/wiki/OpenVPNInteractiveService-v2
(Last edited 9 days ago)

I will be happy to re-write that part of the link above so that it reads
a little more clearly.

Regards



