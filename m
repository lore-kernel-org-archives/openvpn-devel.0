Message-ID: <20101116155849.23656.qmail@...1287...>
Date: Tue, 16 Nov 2010 16:58:49 +0100
From: Peter Stuge <peter@...1287...>
References: <4CDD641F.30408@...515...> <20101112163620.27677.qmail@...1287...>
	<4CDD704B.7080505@...1114...>
	<20101112165541.29963.qmail@...1287...>
	<4CDD7309.3030808@...1114...> <4CDD7559.5000604@...515...>
	<4CDD77B9.8050606@...1114...> <4CDD7D32.2050401@...515...>
	<20101112175153.4861.qmail@...1287...> <4CE2A7F9.2020402@...515...>
MIME-Version: 1.0
In-Reply-To: <4CE2A7F9.2020402@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Removed hardcoded signtool
	dependency	from win/build_all.py
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Samuli Seppänen wrote:
> here's the next version of the patch;

Functionally fine!


>  def main(config):
> +
> +    # Do a signed build by default
> +    unsignedBuild=False

Maybe name the option signedBuild instead? :)


> +    # Check if the SignTool module is present. This avoids ImportErrors popping 
> +    # up annoyingly _after_ the build.
> +    if unsignedBuild == False:
> +       try:
> +          from signtool import SignTool
> +       except (ImportError):
> +          print "ERROR: SignTool python module not found! Can't do a signed build."
> +          sys.exit(1)
> +
> +    if unsignedBuild == True:
> +       print "Doing an unsigned build as requested"

I guess the pythonic way would be simply:

if signedBuild:
  try import..
else:
  print as requested..


> -    sign(config, 'all')
> +
> +    if unsignedBuild == False:
> +       sign(config, 'all')
> +

signedBuild would be nicer, then simply:

if signedBuild:
  sign()


//Peter

