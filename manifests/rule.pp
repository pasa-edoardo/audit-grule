##  params:
##    content: Rule definition
##    order:   Relative order of this rule

define auditd::rule($content='', $order=10, $rules_group='') {
  if $content == '' {
    $body = $name
  } else {
    $body = $content
  }

  validate_numeric($order)
  validate_string($body)
  validate_string($rules_group)

  if $rules_group == '' {
    concat::fragment{ "auditd_fragment_${name}":
      target  => $auditd::params::rules_file,
      order   => $order,
      content => $body,
    }
  }else {
    concat::fragment { "auditd_fragment_${rules_group}_${name}" :
      target  => "${auditd::params::rule_groups_path}${rules_group}",
      order   => $order,
      content => $body,
    }
  }

}
