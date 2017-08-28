References: <CAFHpkQHXhe4UBAePJQXkBYJ+Sahc-3XpVPfPBo5oT6EKbzm3mA@...278...>
 <b524e527-9881-1e25-2ba0-fd7e4117afc4@...1856...>
 <CAFHpkQHbGSsU7gsRcogr+7JzpDXoBd9r669cOpRxp1k8h91Smg@...278...>
 <0526aa24-77dd-7901-a9c9-1287648fcf9a@...2080...>
 <0ab532b3-fdf2-7dcd-b125-42ccedb2e843@...1294...>
 <bb618b3b-42d2-9610-72b3-d7c7e5691e97@...277...>
 <dc75ad56-7bce-9316-ed40-541947306368@...1294...>
 <20170828092507.GT70062@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <4107f34c-ac9c-f049-a4bc-f19e4a0cbcd2@...1227...>
Date: Mon, 28 Aug 2017 13:36:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170828092507.GT70062@...1296...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [Openvpn-users] explicit-exit-notify is ignored
 by previous <connection> blocks.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> 
> Could you throw a log that shows what the server pushes and then the
> warning message (plus the client config, stripped of all sensitive stuff,
> of course) into our trac?  Then it won't get lost and we can go and
> investigate...
> 
> The option parser is a big chunk of magic, so it's possible that some
> extra conditions need to be checked before printing the message...
> 
>
We don't really have that state that we are in pushed options explicitly
in the options parser, we could do streq(file, '[pushed-options]') or
add a field to options to signal that this a pushed context.

Arne

