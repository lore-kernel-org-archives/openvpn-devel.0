References: <38693ff6-f6d2-33a3-889c-96ee85ddb86c@...1856...>
 <20200213104551.25165-1-arne@...1227...>
 <CAGyAFMW4oSH_QANrGRdGzq6y3bfQHROOXnf8dKa2m4gRRuMCrg@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <76c2096d-793c-919a-cd18-386915c73d46@...1227...>
Date: Mon, 17 Feb 2020 11:03:57 +0100
MIME-Version: 1.0
In-Reply-To: <CAGyAFMW4oSH_QANrGRdGzq6y3bfQHROOXnf8dKa2m4gRRuMCrg@...278...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH v2 1/4] Only announce IV_NCP=2 when we
 are willing to support these ciphers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 17.02.20 um 10:58 schrieb Lev Stipakov:
> Hi,
> 
> Since --ncp-ciphers are non-negotiable, why do we need
> to store it in context_1 at all? Cannot we use the value
> from struct options?

The push context do not have access to the options struct. Using options
directly would be massive refactoring. I want to avoid that for this
small patch.

Arne

