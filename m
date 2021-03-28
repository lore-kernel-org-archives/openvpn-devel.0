References: <20201215164221.5995-1-arne@...1227...>
 <20201215164221.5995-2-arne@...1227...>
 <d9fa3e30-32a3-5b81-baeb-716e60fda38c@...2181...>
 <0bfb39c7-8d28-24b9-c830-32424787d489@...1227...>
 <20bfb379-1265-21dc-e027-7836004cfcb0@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <2f93233c-1368-3ad5-2e4a-10c8617a4c3f@...1227...>
Date: Sun, 28 Mar 2021 08:56:51 +0200
MIME-Version: 1.0
In-Reply-To: <20bfb379-1265-21dc-e027-7836004cfcb0@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 2/2] Fix condition to generate session
 keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net


> 
> Basically context_auth is set CAS_SUCCEEDED upon first connection cycle,
> therefore a new connection that re-uses the existing instance will
> already have context_auth set to CAS_SUCCEEDED and a new session key
> will be generated.
> 
> I wonder if the connection can really be fully working if the server
> believes that the client was already setup and does not performs the
> usual connection steps. But this is another story, unrelated to this
> patch...

It works. From the server perspective this new connection is almost the
same as a renegotiation. On a PUSH_REQUEST the server will just send the
same configuration as before. Basically if the new client (which is more
than often the same client) can do everything the previous client did,
everything is well.

Arne

