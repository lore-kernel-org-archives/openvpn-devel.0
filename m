MIME-Version: 1.0
References: <38693ff6-f6d2-33a3-889c-96ee85ddb86c@...1856...>
 <20200213104551.25165-1-arne@...1227...>
 <CAGyAFMW4oSH_QANrGRdGzq6y3bfQHROOXnf8dKa2m4gRRuMCrg@...278...>
 <76c2096d-793c-919a-cd18-386915c73d46@...1227...>
In-Reply-To: <76c2096d-793c-919a-cd18-386915c73d46@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 17 Feb 2020 12:23:25 +0200
Message-ID: <CAGyAFMUGG5L=GZffjBJdmnVADa=+1ws6L83_PuPfegh13iXy-g@...278...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

To clarify - I am not arguing against config_ncp_ciphers in struct tls_options.

The only use of ncp_ciphers in context_1 is this:

   to.config_ncp_ciphers = c->c1.ncp_ciphers;

which can be changed to

  to.config_ncp_ciphers = options->ncp_ciphers;

which allows us to get rid of added "ncp_ciphers" in struct context_1.

-Lev

