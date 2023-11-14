Message-ID: <539f5888-00ae-45f8-8d01-5d315c6dc54c@...1823...>
Date: Tue, 14 Nov 2023 11:08:21 +0400
MIME-Version: 1.0
Content-Language: en-US, ru-RU
References: <13E5C41C-8358-4252-A751-8FDA9EE95B7D@...2722...>
 <0acc8d93-6175-4d7e-a39a-269a9652ac3e@...1823...>
 <f2f54207-f37c-4c0d-96a3-a600cd2bb811@...1823...>
 <ZU3aVt0EgPyOQWEe@...1296...>
 <ae5ddbf4-44fd-4d4b-a045-53274aa9cc5d@...1823...>
 <fe0a4e43-4015-4834-a9bd-8764baf0134a@...1823...>
 <ZU39JoRBq8R_NgD6@...1296...> <ZU6I1MMD980Ervm-@...1296...>
 <CACDCbPq3O71Pjvaj0aBE8Dd-JQA3idZOxP+eyb=9if_MiLREQw@...278...>
 <ZVMcVuF1V_w9lNfO@...1296...>
From: Dmitry Melekhov <dm@...1823...>
In-Reply-To: <ZVMcVuF1V_w9lNfO@...1296...>
Subject: Re: [Openvpn-devel] OpenVPN 2.6.7 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, Greg Cox <gcox@...1057...>
Cc: openvpn-devel@lists.sourceforge.net

14.11.2023 11:05, Gert Doering пишет:
> Hi,
>
> On Sun, Nov 12, 2023 at 06:08:48PM +0000, Greg Cox wrote:
>> Spun this config up, then ran:
>>
>> iptables -t nat -A PREROUTING -i eth0 -p tcp -m multiport --dports 443,80
>> -j REDIRECT --to-ports 1194
>>
>> Within 5 minutes the random web scanners found and segfaulted me.
> ... your port scanners are definitely better than mine - took more like 5
> hours here to crash, but it confirms the current assumptions, ks->state
> being S_UNDEF and ks->send_reliable being NULL.
>
> Now, Arne's patch (if (ks->state == S_UNDEF) { continue; }) *should* have
> fully fixed this, so I'm a bit surprised that we get "it still crashes"
> reports...  will re-test with this setup and see what happens.
>
> gert

I'd like to confirm that after patch and more then 24hours run I have no 
issues.


Thank you!


