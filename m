MIME-Version: 1.0
In-Reply-To: <20180420080026.GZ69387@...1296...>
References: <d75b57da-d1ca-d4ca-41c1-f9af06ec54bb@...1918...>
 <20180420080026.GZ69387@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 20 Apr 2018 10:12:21 -0400
Message-ID: <CAKuzo_jZtgqbNoOifLqhscveDu1gbfVgznx0i1cBpWz25yo9AQ@...278...>
Subject: Re: [Openvpn-devel] [Patch] Support client reason from auth plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: Eric Thorpe <eric@...1918...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi

On Fri, Apr 20, 2018 at 4:00 AM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Fri, Apr 20, 2018 at 03:20:26PM +1000, Eric Thorpe wrote:
>> This patch allows for a client reason to be returned from an auth plugin
>> and sent to the connecting client on an auth fail. This change is
>> backwards compatible with existing plugins and hasn't caused issues with
>> existing plugins like the included pam plugin in our testing. The main
>> purpose of this change is to support dynamic challenge/response from
>> plugins, currently this is only possible from the management interface.
>
> I find this highly interesting, so "feature ACK".  No idea about the
> code though... David and Selva understand plugins :-)

Just to say "me too" for the highly interesting part. Its in my TODO, hopefully
I will get to it soon unless David provides a review in the mean time.

Selva

