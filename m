Message-ID: <52A87373.3070009@...1227...>
Date: Wed, 11 Dec 2013 15:15:15 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <OpenVPN/openvpn/pull/10@...1714...>
In-Reply-To: <OpenVPN/openvpn/pull/10@...1714...>
Subject: Re: [Openvpn-devel] [openvpn] Custom control messages & trigger
	(#10)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: OpenVPN/openvpn <reply+i-24049118-7828ec8fed160fb3c79c0b05c2e1b4850bb0819f-1038539@...1858...>

Am 10.12.13 17:59, schrieb andreax79:
>
> Hi,
> I like to share with you this patch.
> I was searching for a method to notify (e.g. executing a script) a
> client when something happen on the server.
> The scenario is the following: then some configuration are changed on
> the server, the client has to update the
> firewall rules.
> In order to achieve the goal I added a new control message "CUSTOM".
> Then the this message is received, the script specified with
> "--custom" is executed. All the additional argument specified after
> CUSTOM are passed to the script as parameters.
> I added a new command "control" to the management cli to send
> arbitrary control command to clients (by common name or by address/port).
>
> As example, the following command:
> control 192.168.18.164:45421 CUSTOM test
> sends the "CUSTOM test" control message to the client at
> 192.168.18.164:45421.
> On the client, the "--custom" script is executed with "test" as first
> parameter.
>
I have looked very briefly at the patch. But a few points:

* sending arbitrary control messages to the client is probably not a
good idea. Some custom configuration might conflict with future or other
real control messages.
* CUSTOM is a terrible name. something like CUSTOMSERVERMESSAGE, or
async_custom_message or something which actually describes the what the
control message
* We are trying to get away from IPv4 specific/only code as much as
possible. for management command the CID (client id) is better suited to
identify client connections than IP and port pair.

I have not looked at that in details but we already have 'push echo' for
a very similar use case when a connection is initiated.

Arne

P.S.: Main place for discussing/submitting patches is our mailing list.

