References: <1524623120-23498-1-git-send-email-selva.nair@...277...>
 <712cbadd-34a2-b5b2-345e-9c19d237285d@...515...>
 <CAKuzo_jZrCruiZ6u5Ep440FBPUmrH6N45P1PszGxU8EPe6hu0A@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <5762a312-2a09-4411-3951-bf82dc1033af@...515...>
Date: Wed, 25 Apr 2018 18:38:09 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jZrCruiZ6u5Ep440FBPUmrH6N45P1PszGxU8EPe6hu0A@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH tap-windows6] Have the driver version
 display as major.minor.revision.build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Il 25/04/2018 15:42, Selva Nair ha scritto:
> Hi,
> 
> On Wed, Apr 25, 2018 at 3:04 AM, Samuli Seppänen <samuli@...515...> wrote:
>> Feature-ACK, but I have not tested this yet. I think we should increment
>> version to 9.22.2 (a.k.a. 9,22,2,601) though. The current release is 9.22.1.
> 
> Treating this like any other patch, I think version bump should not be
> a part of it, but done only at the point of release as usual. So let's keep
> the purpose here to just change how version is displayed.
> 
> But I did change the date by mistake (left behind from testing) -- will send
> a v2 which keeps the version number and date as is (and update the PR as
> well).
> 
> That said, when a signed test version is made, please bump the version
> and date for testing that it does get recognized as the latest by Windows.
> I could not properly test that due to lack of signature
> 
> Selva
> 

Sounds reasonable.

-- 
Samuli Seppänen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

