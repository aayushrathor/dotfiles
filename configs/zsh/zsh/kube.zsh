# config for kubectl k8s

# autocomplete 
complete -o default -F __start_kubectl k
kubectl () {
    command kubectl $*
    if [[ -z $KUBECTL_COMPLETE ]]
    then
        source <(command kubectl completion zsh)
        KUBECTL_COMPLETE=1 
    fi
}
